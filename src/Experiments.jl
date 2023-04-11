""" A unique collection of variables and instructions to generate useful data.

# Implementation
Defining a new experiment requires implementing five structs and four methods.

The structs to be implemented are:
- `Control` contains all control variables, and serves as primary dispatch object
- `Setup` contains all complex objects calculable from just control variables
- `Independent` contains all independent variables (ie. stuff you plan to plot against)
- `Result` contains all complex objects calculated from independent variables
- `Dependent` contains all dependent variables (ie. stuff you plan to plot)

## IMPORTANT:
One of the main functions of `Control`, `Independent`, and `Dependent`
    is to be written to a csv file.
Thus, all attributes in these structs must be directly serializable
    without tabs or newlines.

The methods to be implemented are:
- `initialize(::Control)::Setup`
- `mapindex(::Control, ::Integer)::Independent`

    This maps an integer index to a specific selection of independent variables,
        facilitating en masse data collection.

- `runtrial(::Control, ::Setup, ::Independent)::Result`
- `synthesize(::Control, ::Setup, ::Independent, ::Result)::Dependent`

By implementing these methods, several additional methods are automatically available.
The most important of these is `collectdata`, so find its documentation too!

"""
module Experiments

#= INTERFACE, IMPLEMENTED BY SUB-PACKAGES =#

abstract type Control end
abstract type Setup end
initialize(::Control)::Setup = error("Not Implemented")
abstract type Independent end
mapindex(::Control,ix::Integer)::Independent = error("Not Implemented")
abstract type Result end
runtrial(::Control,::Setup,::Independent)::Result = error("Not Implemented")
abstract type Dependent end
synthesize(::Control,::Setup,::Independent,::Result)::Dependent = error("Not Implemented")


"""
    runtrial(expmt::Control, xvars::Independent)

Initialize experiment from scratch before running trial.

"""
function runtrial(expmt::Control, xvars::Independent)
    return runtrial(expmt, initialize(expmt), xvars)
end

"""
    synthesize(expmt::Control, xvars::Independent)

Initialize and run experiment from scratch before synthesizing result.

"""
function synthesize(expmt::Control, xvars::Independent)
    setup = initialize(expmt)
    result = runtrial(expmt, setup, xvars)
    return synthesize(expmt, setup, xvars, result)
end

"""
    header(
        io::IO, ::Type{C}, xvars::Type{I}, yvars::Type{D},
    ) where {C <: Control, I <: Independent, D <: Dependent}

Write all attribute names to `io`, separated by tabs.

This method, unlike its counterpart, doesn't require generating a record first.

Attributes in `Independent` are written first, then `Dependent`, then `Control`,
    in the order that they are defined in these structs.

"""
function header(
    io::IO, ::Type{C}, xvars::Type{I}, yvars::Type{D},
) where {C <: Control, I <: Independent, D <: Dependent}
    join(io, fieldnames(C), "\t")
    print(io, "\t")
    join(io, fieldnames(I), "\t")
    print(io, "\t")
    join(io, fieldnames(D), "\t")
    print(io, "\n")
end

"""
    header(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)

Write all attribute names to `io`, separated by tabs.

Attributes in `Independent` are written first, then `Dependent`, then `Control`,
    in the order that they are defined in these structs.

"""
function header(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)
    join(io, fieldnames(typeof(xvars)), "\t")
    print(io, "\t")
    join(io, fieldnames(typeof(yvars)), "\t")
    print(io, "\t")
    join(io, fieldnames(typeof(expmt)), "\t")
    print(io, "\n")
end

"""
    record(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)

Write all variables to `io`, separated by tabs.

Variables in `Independent` are written first, then `Dependent`, then `Control`,
    in the order that they are defined in these structs.

"""
function record(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)
    join(io, (getfield(xvars, var) for var in fieldnames(typeof(xvars))), "\t")
    print(io, "\t")
    join(io, (getfield(yvars, var) for var in fieldnames(typeof(yvars))), "\t")
    print(io, "\t")
    join(io, (getfield(expmt, var) for var in fieldnames(typeof(expmt))), "\t")
    print(io, "\n")
end

"""
    IndexType

The `index` argument in `collectdata` can in principle be any iterable,
        but for the sake of proper dispatch we seem to need to specify it.
"""
const IndexType = Union{Integer, AbstractVector, Base.Generator}

"""
    collectdata(io::IO, expmt::Control, setup::Setup, index; writeheader=false)

Run a series of trials and write the results in tab-delimited .csv format.
For convenience, return the very last result.

`index` is an iterable of `Integer`;
    each is passed to `mapindex` to generate a collection of `Independent` variables.

Pass `writeheader=true` to include a header line in the resulting .csv file.

"""
function collectdata(io::IO, expmt::Control, setup::Setup, index::IndexType;
        writeheader=false)
    result = nothing

    if writeheader
        header(io, typeof(expmt), typeof(xvars), typeof(yvars))
        flush(io)
    end

    for i in index
        xvars = mapindex(expmt, i)
        result = runtrial(expmt, setup, xvars)
        yvars = synthesize(expmt, setup, xvars, result)

        record(io, expmt, xvars, yvars)
        flush(io)
    end

    return result   # RETURN THE LAST RESULT
end

"""
    collectdata(io::IO, expmt::Control, index; writeheader=false)

Initialize experiment from scratch before collecting data.

"""
function collectdata(io::IO, expmt::Control, index::IndexType; writeheader=false)
    setup = initialize(expmt)
    return collectdata(io, expmt, setup, index; writeheader=writeheader)
end

end
