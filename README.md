# Fortran 2018 Examples

![Actions Status](https://github.com/scivision/fortran2018-examples/workflows/cmake/badge.svg)
![Actions Status](https://github.com/scivision/fortran2018-examples/workflows/meson/badge.svg)

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

The CMake or Meson build system automatically walks through the subdirectories:

### CMake

```sh
cmake -B build
cmake --build build --parallel

cd build
ctest --parallel 4 --output-on-failure
```

### Meson

```sh
meson build

meson test -C build
```

## Compilers

### Intel oneAPI

[Intel oneAPI](https://www.scivision.dev/intel-oneapi-fortran-install)
has complete Fortran 2018 support.
Use Intel compilers  (oneAPI or Parallel Studio) by:

* MacOS or Linux:

    ```sh
    cmake --preset=intel
    ```
* Windows

    ```sh
    cmake --preset=intelwin
    ```

## Programs

Each directory has its own README and examples.

* [array/](./array): Array math in modern CMake and Fortran
* [block/](./block): Highly useful `block` element is demonstrated
* [coarray](https://github.com/scivision/fortran-mpi-examples): modern Fortran is the only major compiled language standard with intrinsic massively parallel arrays.
* [contiguous/](./contiguous): Fortran 2008 `contiguous` array examples, including Fortran preprocessor with modern CMake.
* [git/](./git) Git tracability
* [mpi](https://github.com/scivision/fortran-mpi-examples):
* [namelist/](./namelist): Fortran 90 / 2003 Namelist parsing -- native text config files for Fortran
* [openmp/](./openmp): OpenMP threading exmaples
* [random/](./random): random numbers with modern Fortran

---

* [io/](./io): modern Fortran File I/O including resolving absolute path

---

* [real/](./real): Numerous examples dealing with practical features of real floating point numbers, including sentinel NaN and polymorphism.
* [character/](./character): String handling is easy and performant in modern Fortran.
* [standard/](./standard): advanced features that can be done with Fortran standard coding
* [submodule](https://github.com/scivision/fortran-submodule): Fortran 2008 and CMake &ge; 3.12 enable even better large program architecture with `submodule`
* [system/](./system): system (hardware) functionality accessible via Fortran

## Companion libraries and examples

* [C / C++ interfaced with Fortran](https://github.com/scivision/fortran-c-cpp-interface)
* [h5fortran](https://github.com/scivision/h5fortran)
* [netcdf4fortran](https://github.com/scivision/netcdf4fortran)
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

* [Cray Fortran](http://pubs.cray.com/content/S-3901/8.7/cray-fortran-reference-manual/fortran-compiler-introduction)
* [Flang Wiki](https://github.com/flang-compiler/flang/wiki)
* [GNU Fortran docs](https://gcc.gnu.org/onlinedocs/)
* [IBM XL](https://www-01.ibm.com/support/docview.wss?uid=swg27036672)
* [Intel Fortran](https://software.intel.com/en-us/fortran-compiler-developer-guide-and-reference)
* [NAG Fortran](https://www.nag.com/nagware/np/r62_doc/manual/compiler.html)
* [Nvidia HPC SDK](https://docs.nvidia.com/hpc-sdk/index.html)

### Surveys

* [2018 modern Fortran user survey](http://www.fortran.bcs.org/2018/FortranBenefitsSurvey_interimrep_Aug2018.pdf)
