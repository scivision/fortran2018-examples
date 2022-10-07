# Fortran 2018 Examples

![Actions Status](https://github.com/scivision/fortran2018-examples/workflows/cmake/badge.svg)

Easy examples of scientific computing with modern, powerful, easy Fortran 2018 standard.
Fortran 2018 began as the TS18508 extension, formerly known as Fortran 2015.

Modern Fortran benefits from modern CMake, which supports Fortran features such as

* [submodule](https://github.com/scivision/fortran-submodule)
* preprocessing
* detecting specific support of Fortran features (so users know their compiler is too old)

Based on widespread compiler support and beneficial features, most new and upgraded Fortran programs should use at least portions of the Fortran 2008 standard.

## Prereq

* Linux: `apt install cmake gfortran`
* Mac: `brew install gcc cmake`
* Windows MSYS2: `pacman -S mingw-w64-x86_64-gcc-fortran mingw-w64-x86_64-cmake`

## Build

```sh
cmake -B build
cmake --build build --parallel

cd build
ctest --output-on-failure
```

## Programs

Each directory has its own README and examples.

* [array/](./src/array): Array math in modern CMake and Fortran
* [block/](./src/block): Highly useful `block` element is demonstrated
* [coarray](https://github.com/scivision/fortran-mpi-examples): modern Fortran is the only major compiled language standard with intrinsic massively parallel arrays.
* [contiguous/](./src/contiguous): Fortran 2008 `contiguous` array examples, including Fortran preprocessor with modern CMake.
* [git/](./src/git) Git tracability
* [mpi](https://github.com/scivision/fortran-mpi-examples):
* [namelist/](./src/namelist): Fortran 90 / 2003 Namelist parsing -- native text config files for Fortran
* [openmp/](./src/openmp): OpenMP threading exmaples
* [random/](./src/random): random numbers with modern Fortran

---

* [io/](./src/io): modern Fortran File I/O including resolving absolute path

---

* [real/](./src/real): Numerous examples dealing with practical features of real floating point numbers, including sentinel NaN and polymorphism.
* [character/](./src/character): String handling is easy and performant in modern Fortran.
* [standard/](./src/standard): advanced features that can be done with Fortran standard coding
* [submodule](https://github.com/scivision/fortran-submodule): Fortran 2008 and CMake &ge; 3.12 enable even better large program architecture with `submodule`
* [system/](./src/system): system (hardware) functionality accessible via Fortran

## Companion libraries and examples

* [C / C++ interface to/from Fortran](https://github.com/scivision/fortran-cpp-interface)
* [h5fortran](https://github.com/geospace-code/h5fortran-mpi)
* [nc4fortran](https://github.com/geospace-code/nc4fortran)
* [sparse-fortran](https://github.com/scivision/sparse-fortran)

## Resources

### Fortran standards

* Fortran I 1956 [manual](https://www.fortran.com/FortranForTheIBM704.pdf)
* Fortran II 1958 [manual](http://archive.computerhistory.org/resources/text/Fortran/102653989.05.01.acc.pdf)

* Fortran 66 [standard](http://web.eah-jena.de/~kleine/history/languages/ansi-x3dot9-1966-Fortran66.pdf)

* Fortran 77 [langauge reference](http://physik.uibk.ac.at/hephy/praktikum/fortran_manual.pdf)
* Fortran [77](http://www.fortran.com/F77_std/f77_std.html)

* Fortran 90 / 95 [manual](http://www.chem.ucl.ac.uk/resources/history/people/vanmourik/images/Fortran%2095-manual.pdf)

* Fortran [2003](https://wg5-fortran.org/f2003.html)
* Fortran [2008](https://wg5-fortran.org/f2008.html)
* Fortran [2018](https://wg5-fortran.org/f2018.html)

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
* [IBM Open XL](https://www.ibm.com/support/pages/ibm-open-xl-fortran-linux-power-and-xl-fortran-linux-documentation-library)
* [Intel Fortran](https://www.intel.com/content/www/us/en/develop/documentation/fortran-compiler-oneapi-dev-guide-and-reference/top.html)
* [NAG Fortran](https://www.nag.com/content/nag-fortran-compiler-documentation)
* [Nvidia HPC SDK](https://docs.nvidia.com/hpc-sdk)

### Surveys

* [2018 modern Fortran user survey](http://www.fortran.bcs.org/2018/FortranBenefitsSurvey_interimrep_Aug2018.pdf)
