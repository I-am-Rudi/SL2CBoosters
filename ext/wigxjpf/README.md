# WIGXJPF-CMake

This project is a fork of the WIGXJPF library that includes a simple CMake project for building and packaging.
It aims to allow the project to be used as a CMake library in a subdirectory of another project
or as a dependency for use via `find_project(...)`.

It has been validated in my own use cases, but has not been systematically tested.
Any feedback/errors are gladly accepted in the issue tracker.

# Licensing and acknowledgments

For a full description of the library, see the [WIGXJPF Readme](README).

The project is licensed under the GPL v3 and the LGPL v3.
Specifically the LGPL is a variant of the GPL that loosens the copyleft restrictions
to allow projects licensed under more permissive open-source terms
to use this library.

The recommended way to refer to WIGXJPF, when used for computations that are
published in a research article, is to cite the following paper

H. T. Johansson and C. Forssén, Fast and Accurate Evaluation of Wigner 3j,
6j, and 9j Symbols Using Prime Factorization and Multiword Integer Arithmetic,
SIAM J. Sci. Comput., 38(1) (2016), A376-A384.

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

Pre-print (2015) at arXiv:1504.08329.


