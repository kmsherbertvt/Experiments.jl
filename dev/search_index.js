var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = Experiments","category":"page"},{"location":"#Experiments","page":"Home","title":"Experiments","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Experiments.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This package defines a framework for generating useful data in a consistent manner.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The idea is that, for any given experiment,     you can implement a few intuitive structs organizing your input parameters,     and a few intuitive methods to actually run your experiment,     and this class handles the IO (ie. writing to a CSV file).","category":"page"},{"location":"","page":"Home","title":"Home","text":"This framework is only particularly useful     when the outputs you really care about are all scalar. I think it's good practice to always try boiling a problem down     to scalar inputs and outputs when you can,     but it won't always work. Personally, I see this framework as useful for late-stage research:     I have already figured out what the trends are,     I know what I want to plot,     and I can use this package to help me generate a lot of data.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Experiments]","category":"page"},{"location":"#Experiments.Experiments","page":"Home","title":"Experiments.Experiments","text":"A unique collection of variables and instructions to generate useful data.\n\nImplementation\n\nDefining a new experiment requires implementing five structs and four methods.\n\nThe structs to be implemented are:\n\nControl contains all control variables, and serves as primary dispatch object\nSetup contains all complex objects calculable from just control variables\nIndependent contains all independent variables (ie. stuff you plan to plot against)\nResult contains all complex objects calculated from independent variables\nDependent contains all dependent variables (ie. stuff you plan to plot)\n\nIMPORTANT:\n\nOne of the main functions of Control, Independent, and Dependent     is to be written to a csv file. Thus, all attributes in these structs must be directly serializable     without tabs or newlines.\n\nThe methods to be implemented are:\n\ninitialize(::Control)::Setup\nmapindex(::Control, ::Integer)::Independent\nThis maps an integer index to a specific selection of independent variables,       facilitating en masse data collection.\nruntrial(::Control, ::Setup, ::Independent)::Result\nsynthesize(::Control, ::Setup, ::Independent, ::Result)::Dependent\n\nBy implementing these methods, several additional methods are automatically available. The most important of these is collectdata, so find its documentation too!\n\n\n\n\n\n","category":"module"},{"location":"#Experiments.IndexType","page":"Home","title":"Experiments.IndexType","text":"IndexType\n\nThe index argument in collectdata can in principle be any iterable,         but for the sake of proper dispatch we seem to need to specify it.\n\n\n\n\n\n","category":"type"},{"location":"#Experiments.collectdata-Tuple{IO, Experiments.Control, Experiments.Setup, Union{Integer, Base.Generator, AbstractVector}}","page":"Home","title":"Experiments.collectdata","text":"collectdata(io::IO, expmt::Control, setup::Setup, index; writeheader=false)\n\nRun a series of trials and write the results in tab-delimited .csv format. For convenience, return the very last result.\n\nindex is an iterable of Integer;     each is passed to mapindex to generate a collection of Independent variables.\n\nPass writeheader=true to include a header line in the resulting .csv file.\n\n\n\n\n\n","category":"method"},{"location":"#Experiments.collectdata-Tuple{IO, Experiments.Control, Union{Integer, Base.Generator, AbstractVector}}","page":"Home","title":"Experiments.collectdata","text":"collectdata(io::IO, expmt::Control, index; writeheader=false)\n\nInitialize experiment from scratch before collecting data.\n\n\n\n\n\n","category":"method"},{"location":"#Experiments.header-Tuple{IO, Experiments.Control, Experiments.Independent, Experiments.Dependent}","page":"Home","title":"Experiments.header","text":"header(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)\n\nWrite all attribute names to io, separated by tabs.\n\nAttributes in Independent are written first, then Dependent, then Control,     in the order that they are defined in these structs.\n\n\n\n\n\n","category":"method"},{"location":"#Experiments.record-Tuple{IO, Experiments.Control, Experiments.Independent, Experiments.Dependent}","page":"Home","title":"Experiments.record","text":"record(io::IO, expmt::Control, xvars::Independent, yvars::Dependent)\n\nWrite all variables to io, separated by tabs.\n\nVariables in Independent are written first, then Dependent, then Control,     in the order that they are defined in these structs.\n\n\n\n\n\n","category":"method"},{"location":"#Experiments.runtrial-Tuple{Experiments.Control, Experiments.Independent}","page":"Home","title":"Experiments.runtrial","text":"runtrial(expmt::Control, xvars::Independent)\n\nInitialize experiment from scratch before running trial.\n\n\n\n\n\n","category":"method"},{"location":"#Experiments.synthesize-Tuple{Experiments.Control, Experiments.Independent}","page":"Home","title":"Experiments.synthesize","text":"synthesize(expmt::Control, xvars::Independent)\n\nInitialize and run experiment from scratch before synthesizing result.\n\n\n\n\n\n","category":"method"}]
}
