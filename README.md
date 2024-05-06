# Fortran 2018 Examples

[![cmake](https://github.com/scivision/fortran2018-examples/actions/workflows/cmake.yml/badge.svg)](https://github.com/scivision/fortran2018-examples/actions/workflows/cmake.yml)
[![oneapi-linux](https://github.com/scivision/fortran2018-examples/actions/workflows/oneapi-linux.yml/badge.svg)](https://github.com/scivision/fortran2018-examples/actions/workflows/oneapi-linux.yml)
[![fpm](https://github.com/scivision/fortran2018-examples/actions/workflows/fpm.yml/badge.svg)](https://github.com/scivision/fortran2018-examples/actions/workflows/fpm.yml)

Standalone examples of Fortran 2018 and 2023 standard features.
Popular,
[free-to-use Fortran compilers](https://www.scivision.dev/free-c-fortran-compilers/)
(GCC, Intel oneAPI, NVIDIA, Cray, IBM OpenXL, AOCC, Flang) and paid compilers such as NAG support all or many Fortran 2008 and 2018 standards.

Some standard Fortran features are so distinctive that we've put examples in separate repos:

* [C / C++ interface to/from Fortran](https://github.com/scivision/fortran-cpp-interface)
* [Fortran submodule](https://github.com/scivision/fortran-submodule)
* [Fortran coarray](https://github.com/scivision/fortran-coarray-mpi-examples): modern Fortran is the only major compiled language standard with intrinsic massively parallel arrays. Also contains MPI examples.
* [do concurrent, OpenMP, OpenACC](https://github.com/scivision/fortran-parallel-examples): parallel execution with Fortran directives and native syntax.

The examples are built with CMake:

```sh
cmake --workflow --preset default
```

or to do each step manually:

```sh
cmake -B build
cmake --build build
ctest --test-dir build -V
```

## Programs

The standalone examples are organized under [test/](./test/) directory, including:

* array: Array math in modern CMake and Fortran
* Git traceability
* namelist: Fortran 90 / 2003 Namelist parsing -- native text config files for Fortran
* io: modern Fortran File I/O including resolving absolute path
* real: Numerous examples dealing with practical features of real floating point numbers, including sentinel NaN and polymorphism.
* character: String handling is easy and performant in modern Fortran.
* standard: advanced features that can be done with Fortran standard coding
* submodule: Fortran 2008 and CMake &ge; 3.12 enable even better large program architecture with `submodule`
* system: system (hardware) functionality accessible via Fortran

## Companion libraries and examples

* [object-oriented Fortran HDF5 interface: h5fortran](https://github.com/geospace-code/h5fortran-mpi)
* [object-oriented Fortran NetCDF4 interface: nc4fortran](https://github.com/geospace-code/nc4fortran)
* [sparse-matrix examples in Fortran](https://github.com/scivision/sparse-fortran)

## Resources

### Fortran standards

* Fortran I 1956 [manual](https://www.fortran.com/FortranForTheIBM704.pdf)
* Fortran II 1958 [manual](http://archive.computerhistory.org/resources/text/Fortran/102653989.05.01.acc.pdf)

* Fortran 66 [standard](http://web.eah-jena.de/~kleine/history/languages/ansi-x3dot9-1966-Fortran66.pdf)

* Fortran 77 [language reference](http://physik.uibk.ac.at/hephy/praktikum/fortran_manual.pdf)
* Fortran [77](http://www.fortran.com/F77_std/f77_std.html)

* Fortran 90 / 95 [manual](http://www.chem.ucl.ac.uk/resources/history/people/vanmourik/images/Fortran%2095-manual.pdf)

* Fortran [2003](https://wg5-fortran.org/f2003.html)
* Fortran [2008](https://wg5-fortran.org/f2008.html)
* Fortran [2018](https://wg5-fortran.org/f2018.html)
* Fortran [2023](https://wg5-fortran.org/f2023.html)

### Books

* [Modern Fortran Explained: Incorporating Fortran 2018](https://global.oup.com/academic/product/modern-fortran-explained-9780198811886).
  Metcalf, Reid, Cohen. 5th Ed, Nov 2018. ISBN:  978-0198811886.
* [Modern Fortran: Building Efficient Parallel Applications](https://www.manning.com/books/modern-fortran).
  [Milan Curcic](https://twitter.com/realmilancurcic).
  Feb. 2019. ISBN: 978-1617295287.

### Compiler User Guides

* [Cray Fortran](https://support.hpe.com/hpesc/public/docDisplay?docId=a00115296en_us)
* [Flang Wiki](https://github.com/flang-compiler/flang/wiki)
* [GNU Fortran docs](https://gcc.gnu.org/onlinedocs/)
* [IBM OpenXL](https://www.ibm.com/support/pages/ibm-open-xl-fortran-linux-power-and-xl-fortran-linux-documentation-library)
* [Intel Fortran](https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top.html)
* [NAG Fortran](https://www.nag.com/content/nag-fortran-compiler-documentation)
* [NVIDIA HPC SDK](https://docs.nvidia.com/hpc-sdk)

### Surveys

* [2018 modern Fortran user survey](http://www.fortran.bcs.org/2018/FortranBenefitsSurvey_interimrep_Aug2018.pdf)
