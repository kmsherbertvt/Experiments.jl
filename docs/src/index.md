```@meta
CurrentModule = Experiments
```

# Experiments

Documentation for [Experiments](https://github.com/kmsherbertvt/Experiments.jl).

This package defines a framework for generating useful data in a consistent manner.

The idea is that, for any given experiment,
    you can implement a few intuitive structs organizing your input parameters,
    and a few intuitive methods to actually *run* your experiment,
    and this class handles the IO (ie. writing to a CSV file).

This framework is only particularly useful
    when the outputs you *really* care about are all scalar.
I think it's good practice to *always* try boiling a problem down
    to scalar inputs and outputs when you can,
    but it won't always work.
Personally, I see this framework as useful for late-stage research:
    I have already figured out what the trends are,
    I know what I want to plot,
    and I can use this package to help me generate a lot of data.

```@index
```

```@autodocs
Modules = [Experiments]
```
