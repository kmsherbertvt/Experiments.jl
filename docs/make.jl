using Experiments
using Documenter

DocMeta.setdocmeta!(Experiments, :DocTestSetup, :(using Experiments); recursive=true)

makedocs(;
    modules=[Experiments],
    authors="Kyle Sherbert <kyle.sherbert@vt.edu> and contributors",
    repo="https://github.com/kmsherbertvt/Experiments.jl/blob/{commit}{path}#{line}",
    sitename="Experiments.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://kmsherbertvt.github.io/Experiments.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kmsherbertvt/Experiments.jl",
    devbranch="main",
)
