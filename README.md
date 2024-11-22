# SL2CBoosters.jl

A Julia package for computing SL(2,C) boosters, providing efficient C-based calculations with a Julia interface.

## Installation

### Prerequisites

Before installing the package, make sure you have the following system dependencies:

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install build-essential cmake libgmp-dev libmpfr-dev libmpc-dev
```

#### Arch Linux/Manjaro
```bash
sudo pacman -S base-devel cmake gmp mpfr libmpc
```

#### macOS
```bash
brew install cmake gmp mpfr libmpc
```

#### Windows
1. Install [MSYS2](https://www.msys2.org/)
2. Open MSYS2 MinGW64 shell and run:
```bash
pacman -Syu
pacman -S mingw-w64-x86_64-toolchain mingw-w64-x86_64-cmake mingw-w64-x86_64-gmp mingw-w64-x86_64-mpfr mingw-w64-x86_64-mpc
```
3. Add `C:\msys64\mingw64\bin` to your system PATH

### Package Installation

Install the package directly from GitHub:
```julia
import Pkg
Pkg.develop(Pkg.PackageSpec(name="SL2CBoosters", url="https://github.com/I-am-Rudi/SL2CBoosters.git"))
```

## Usage

```julia
using SL2CBoosters

# Example usage code here
```

## Development

For local development:

1. Clone the repository:
```bash
git clone https://github.com/I-am-Rudi/SL2CBoosters.git
cd SL2CBoosters
```

2. Set up local development:
```julia
import Pkg
Pkg.develop(path=".")
```

## Troubleshooting

If you encounter build issues:

1. Clean and rebuild:
```julia
import Pkg
Pkg.rm("SL2CBoosters")
Pkg.develop(Pkg.PackageSpec(name="SL2CBoosters", url="https://github.com/I-am-Rudi/SL2CBoosters.git"))
```

2. For verbose build output:
```julia
Pkg.build("SL2CBoosters", verbose=true)
```

## Common Issues

- If you get library loading errors, ensure all system dependencies are properly installed
- For Windows users, verify that MSYS2's bin directory is in your system PATH
- For macOS users with Apple Silicon, ensure you're using the ARM64 version of Julia

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

Inhgerited from SL2CFOAM-NEXT

SL2CBOOSTERS is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

SL2CBOOSTERS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with SL2CBOOSTERS. If not, see http://www.gnu.org/licenses/.

If you use the library, cite the following paper: "Francesco Gozzini, A high-performance code for EPRL spin foam amplitudes, Class. Quantum Grav. 38, 225010, doi:10.1088/1361-6382/ac2b0b."

## Citations

Francesco Gozzini, A high-performance code for EPRL spin foam amplitudes, Class. Quantum Grav. 38, 225010, doi:10.1088/1361-6382/ac2b0b."

```
@article{johansson2016,
   author = {H. T. Johansson and C. Forss\’en},
    title = {Fast and Accurate Evaluation of Wigner 3\$j\$, 6\$j\$, and 9\$j\$
Symbols Using Prime Factorization and Multiword Integer Arithmetic},
  journal = {SIAM Journal on Scientific Computing},
   volume = {38},
   number = {1},
    pages = {A376-A384},
     year = {2016},
      doi = {10.1137/15M1021908},
      URL = {http://dx.doi.org/10.1137/15M1021908},
   eprint = {http://dx.doi.org/10.1137/15M1021908}
}
```

cmake implementation of wigxjpf: `https://github.com/cheshyre/wigxjpf-cmake/blob/main/README.md`

## Contact

[Your contact information or how to reach the maintainers]

## Acknowledgments

- [List any acknowledgments, contributors, or related projects]