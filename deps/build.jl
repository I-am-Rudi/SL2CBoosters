using CMake

# Get the package root directory (parent of deps)
const package_root = dirname(@__DIR__)
# Set build directory within deps
const builddir = joinpath(@__DIR__, "build")
const prefix = joinpath(@__DIR__, "usr")

# Create and enter build directory
mkpath(builddir)
cd(builddir)

# Check for system dependencies with multiple possible names
function check_dependency(names::Vector{String})
    @static if Sys.isunix()
        for name in names
            try
                run(`pkg-config --exists $name`)
                return true
            catch
                continue
            end
        end
        @warn "System library $(names[1]) not found. Please install it."
        return false
    end
    return true
end

# Check required dependencies with alternative names
required_libs = [
    ["gmp"],
    ["mpfr"],
    ["mpc", "libmpc"]
]
all_deps_found = all(check_dependency.(required_libs))

if !all_deps_found
    @warn """
    Some dependencies appear to be missing. If you have already installed them,
    they might be installed under different names. Common package names are:
    Ubuntu/Debian: libgmp-dev libmpfr-dev libmpc-dev
    Fedora: gmp-devel mpfr-devel libmpc-devel
    Arch: gmp mpfr libmpc
    """
end

# Run CMake configuration with correct source directory path
cmake_args = [
    "-DCMAKE_INSTALL_PREFIX=$prefix",
    "-DCMAKE_BUILD_TYPE=Release",
    "-DBUILD_SHARED_LIBS=ON",
    "-DUSE_OPENMP=ON",
    "-DUSE_JULIA=OFF",  # Disable Julia for now
    package_root
]

try
    @info "Running CMake in directory: $builddir"
    @info "Using source directory: $package_root"
    run(`cmake $cmake_args`)
    run(`cmake --build . --config Release`)
    run(`cmake --install .`)

    # Set the library path for the installed wigxjpf
    @static if Sys.isunix()
        lib_path = joinpath(prefix, "lib")
        ENV["LD_LIBRARY_PATH"] = get(ENV, "LD_LIBRARY_PATH", "") * ":" * lib_path
    end
catch e
    @error "Build failed" exception=e
    error("Failed to build SL2CBoosters")
end

# Create a deps.jl file to store library paths
deps_file = joinpath(@__DIR__, "deps.jl")
open(deps_file, "w") do f
    println(f, "# This file is automatically generated")
    println(f, "# Do not edit")
    println(f)
    println(f, "const libdir = \"", escape_string(joinpath(prefix, "lib")), "\"")
    println(f, "const sl2cboosters_path = \"", escape_string(joinpath(prefix, "lib", "libsl2cboosters.so")), "\"")
    println(f, "const wigxjpf_path = \"", escape_string(joinpath(prefix, "lib", "libwigxjpf.so")), "\"")
end