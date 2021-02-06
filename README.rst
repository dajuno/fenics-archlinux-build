====================
FEniCS build scripts
====================

.. note::

    **THIS INSTALLS LEGACY FEniCS 2019 FROM BITBUCKET**

Build DOLFIN/FEniCS, mshr and PETSc/SLEPc within a Python virtualenv, using
system packages for OpenMPI, OpenBLAS, LAPACK, HDF5, etc, from the Arch Linux
official repository.
*(Build scripts originally inspired by Jack Hale.)*

Dependencies on ArchLinux
=========================

.. note::

    Updates of the system packages such as hdf5 are likely to break dolfin. A
    better solution than this mix of compiled and packaged dependencies could
    be to manually compile all dependencies.

System packages
---------------

* openmpi
* hdf5-openmpi
* openblas-lapack
* eigen
* pybind11
* doxygen
* cython
* jupyter

Python packages:

* python-mpi4py
* python-h5py
* python-sympy

For mshr:

* gmp
* mpfr




Compiled from source
--------------------

* Boost 1.73
* PETSc 3.13 with suitesparse, mumps, ...
* SLEPc 3.13

Instructions
============

1. Configure and run :code:`build_all.sh`:

   .. code:: shell
   
      ./build_all.sh |& tee build.log
  
2. Load the FEniCS environment (modules, environment variables, python venv) with:

    .. code:: shell

        source $PREFIX/share/dolfin/dolfin.conf

   where :code:`$PREFIX` is as specified in :code:`build_all.sh`.

3. Test the installation with the Poisson example:

    .. code:: python3 test_poisson.py

   and in parallel:

    .. code:: shell

        mpirun -n 4 python3 test_poisson.py
