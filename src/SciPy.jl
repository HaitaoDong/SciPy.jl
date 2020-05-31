"""
A Julia interface module for SciPy

- [GitHub repository: AtsushiSakai/SciPy.jl: Julia interface for SciPy](https://github.com/AtsushiSakai/SciPy.jl)
- [Stable Doc](https://atsushisakai.github.io/SciPy.jl/stable)
- [Dev Doc](https://atsushisakai.github.io/SciPy.jl/dev)

"""
module SciPy

using PyCall
using InteractiveUtils

export print_configulations
export constants

const scipy = PyNULL()

"""
Scipy.constants module

- [Constants (scipy.constants) Reference Guide](https://docs.scipy.org/doc/scipy/reference/constants.html)

# Examples

You can access each constants:

```julia-repl
julia> SciPy.constants.golden
1.618033988749895

julia> SciPy.constants.physical_constants["electron mass"] 
(9.10938356e-31, "kg", 1.1e-38)

julia> SciPy.constants.convert_temperature([-40, 40.0], "Celsius", "Kelvin") 

2-element Array{Float64,1}:
 233.14999999999998
 313.15

```
"""
const constants = PyNULL()


"""
Module initialization function
"""
function __init__()

    copy!(scipy, pyimport_conda("scipy", "scipy"))
    copy!(constants, pyimport_conda("scipy.constants", "scipy"))

end

"""
Print configulations like:
- Julia version
- Python version
- Python path
- scipy version
"""
function print_configulations()
    println("==== SciPy.jl configulations ====")
    println("-- Julia settings --")
    versioninfo()
    println("-- PyCall.jl settings --")
    @show PyCall.pyversion
    @show PyCall.libpython
    @show PyCall.pyprogramname
    @show PyCall.conda
    println("-- Scipy settings --")
    @show scipy.__version__
    @show scipy.version.full_version
    @show scipy.version.git_revision
end


end
