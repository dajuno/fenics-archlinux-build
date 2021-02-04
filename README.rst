====================
FEniCS build scripts
====================

.. note:: THIS INSTALLS LEGACY FENICS 2019 FROM BITBUCKET

Build DOLFIN/FENICS, mshr within a Python virtualenv, using system dependencies
for PETSc, OpenMPI, BLAS, LAPACK, HDF5, etc, from the Arch Linux official
repository and AUR.

Dependencies on ArchLinux (not complete)
========================================

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


Instructions
============

1. Configure and run :code:`build_all.sh`:

   .. code:: ./build_all.sh |& tee build.log
  
2. Load the FEniCS environment (modules, environment variables, python venv) with:

    .. code:: shell

        source $PREFIX/share/dolfin/dolfin.conf

    where :code:`$PREFIX` is as specified in :code:`build_all.sh`.

3. Test the installation with the Poisson example:

    .. code:: python3 test_poisson.py

    and in parallel:

    .. code:: shell

        mpirun -n 4 python3 test_poisson.py
