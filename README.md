# FEniCS build scripts

Build DOLFIN/FENICS, mshr within a Python virtualenv, using system dependencies
for PETSc, OpenMPI, BLAS, LAPACK, HDF5, etc, from the Arch Linux official
repository and AUR.

## Dependencies on ArchLinux (not complete)

* openmpi
* hdf5-openmpi
* openblas-lapack
* boost
* eigen
* pybind11
* doxygen
* petsc-git
* slepc-git

For mshr:

* gmp
* mpfr


## Instructions

1. Configure and run `build_all.sh`:

    ```
        ./build_all.sh |& tee build.log
    ```
  
2. Load the FEniCS environment (modules, environment variables, python venv) with:

    ```shell
      source $PREFIX/share/dolfin/dolfin.conf
    ```

    where `$PREFIX` is as specified in `build_all.sh`.

3. Test the installation with the Poisson example:

    ```shell
        python3 test_poisson.py
    ```

    and in parallel:

    ```shell
        mpirun -n 4 python3 test_poisson.py
    ```
