using CMake
using Downloads
using Tar
using CodecZlib

# Get the package root directory (parent of deps)
const package_root = dirname(@__DIR__)
const builddir = joinpath(@__DIR__, "build")
const prefix = joinpath(@__DIR__, "usr")
const libdir = joinpath(prefix, "lib")

# Clean old build files
if isdir(builddir)
    @info "Cleaning old build directory..."
    rm(builddir, recursive=true)
end

if isdir(prefix)
    @info "Cleaning old installation..."
    rm(prefix, recursive=true)
end

# Create necessary directories
mkpath(builddir)
mkpath(libdir)

# Run CMake configuration with correct source directory path
cmake_args = [
    "-DCMAKE_INSTALL_PREFIX=$prefix",
    "-DCMAKE_BUILD_TYPE=Release",
    "-DBUILD_SHARED_LIBS=ON",
    "-DUSE_OPENMP=ON",
    "-DUSE_JULIA=OFF",
]

try
    @info "Running CMake in directory: $builddir"
    cd(builddir) do
        run(`cmake $cmake_args $package_root`)
        run(`cmake --build . --config Release`)
        run(`cmake --install .`)
    end
    
    # Create wrapper script for library paths
    wrapper_path = joinpath(@__DIR__, "load_libs.jl")
    open(wrapper_path, "w") do f
        write(f, """
        # This file is automatically generated
        const depsdir = "$(escape_string(prefix))"
        const libdir = "$(escape_string(libdir))"

        # Ensure the library directory is in DL_LOAD_PATH
        using Libdl
        push!(DL_LOAD_PATH, libdir)
        """)
    end

catch e
    @error "Build failed" exception=e
    error("Failed to build SL2CBoosters")
end
