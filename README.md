# SL2CBoosters Installation Guide

SL2CBoosters is a Julia package that provides C-based computation of SL(2,C) boosters. This guide covers installation on various operating systems.

## Prerequisites

You need to have Julia (version 1.6 or higher) installed on your system. You can download it from [https://julialang.org/downloads/](https://julialang.org/downloads/).

### Ubuntu/Debian-based Systems

1. Install system dependencies:
```bash
sudo apt update
sudo apt install build-essential cmake libgmp-dev libmpfr-dev libmpc-dev
```

2. Install the package:
```julia
using Pkg
Pkg.add("https://github.com/your-username/SL2CBoosters.jl")  # Replace with actual repo URL
```

Or for local development:
```julia
using Pkg
Pkg.develop(path="/path/to/SL2CBoosters")
```

### Arch Linux/Manjaro

1. Install system dependencies:
```bash
sudo pacman -S base-devel cmake gmp mpfr libmpc
```

2. Install the package:
```julia
using Pkg
Pkg.add("https://github.com/your-username/SL2CBoosters.jl")  # Replace with actual repo URL
```

Or for local development:
```julia
using Pkg
Pkg.develop(path="/path/to/SL2CBoosters")
```

### macOS

1. Install dependencies using Homebrew:
```bash
# Install Homebrew if you haven't already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install cmake gmp mpfr libmpc
```

2. Install the package:
```julia
using Pkg
Pkg.add("https://github.com/your-username/SL2CBoosters.jl")  # Replace with actual repo URL
```

Or for local development:
```julia
using Pkg
Pkg.develop(path="/path/to/SL2CBoosters")
```

### Windows

1. Install dependencies:
   - Install [MSYS2](https://www.msys2.org/) following their installation guide
   - Open MSYS2 MinGW 64-bit terminal and install dependencies:
   ```bash
   pacman -Syu
   pacman -S mingw-w64-x86_64-toolchain mingw-w64-x86_64-cmake mingw-w64-x86_64-gmp mingw-w64-x86_64-mpfr mingw-w64-x86_64-mpc
   ```

2. Add MSYS2's MinGW bin directory to your system PATH:
   - Navigate to System Properties -> Advanced -> Environment Variables
   - Add `C:\msys64\mingw64\bin` to your system PATH

3. Install the package:
   - Open Julia and run:
   ```julia
   using Pkg
   Pkg.add("https://github.com/your-username/SL2CBoosters.jl")  # Replace with actual repo URL
   ```

   Or for local development:
   ```julia
   using Pkg
   Pkg.develop(path="C:\\path\\to\\SL2CBoosters")
   ```

## Verifying Installation

To verify that the installation was successful, run:

```julia
using SL2CBoosters
```

If no errors appear, the installation was successful.

## Common Issues

### Missing Libraries
If you get an error about missing libraries, ensure all dependencies are installed and that your system's library path includes the installation directories.

### Build Failures
If the build fails, try:
```julia
import Pkg
Pkg.build("SL2CBoosters", verbose=true)
```
This will show detailed build output to help diagnose the issue.

### Windows-specific Issues
- If you get "command not found" errors, ensure MSYS2's bin directory is in your PATH
- If you get DLL load errors, ensure all MSYS2 dependencies are installed and the bin directory is in your PATH

### macOS-specific Issues
- If using Apple Silicon (M1/M2), ensure you're using the ARM64 version of Julia
- If Homebrew is installed in a non-standard location, you may need to set `HOMEBREW_PREFIX` environment variable

## Development Setup

For development:

1. Clone the repository:
```bash
git clone https://github.com/your-username/SL2CBoosters.jl.git
cd SL2CBoosters.jl
```

2. Activate the development environment:
```julia
using Pkg
Pkg.develop(path=".")
```

3. Run tests:
```julia
Pkg.test("SL2CBoosters")
```

## Updating

To update to the latest version:
```julia
using Pkg
Pkg.update("SL2CBoosters")
```

## Uninstallation

To remove the package:
```julia
using Pkg
Pkg.rm("SL2CBoosters")
```

## Support

If you encounter any issues not covered in this guide, please:
1. Check the [Issues](https://github.com/your-username/SL2CBoosters.jl/issues) page
2. Open a new issue if your problem hasn't been reported
