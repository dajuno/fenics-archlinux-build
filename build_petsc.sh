#!/bin/bash
set -e

source env_build.sh

# export CXXFLAGS="${CXXFLAGS} -std=c++0x"

echo "Downloading and building PETSc ${PETSC_VERSION}"

mkdir -p "$BUILD_DIR/tar"

# FROM https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=petsc-git
generic_flags="-fPIC -O3 -march=x86-64 -mtune=generic"
# generic_flags="-fPIC -fopenmp -O3 -march=amdfam10 -mtune=generic"

export COPTFLAGS="-O3"
export CXXOPTFLAGS="-O3"
export FOPTFLAGS="-O3"
export CPPFLAGS="$generic_flags"
export CFLAGS="$generic_flags"
export CXXFLAGS="$generic_flags"
export FFLAGS="$generic_flags"
export FCFLAGS="$generic_flags"
export F90FLAGS="$generic_flags"
export F77FLAGS="$generic_flags"
# if petsc is installed system wide (e.g.)
unset PETSC_DIR

# NOTE: pip install petsc4py does not work for 3.13. and python 3.10, as was done in
# ./build_python_modules.sh
# https://gitlab.com/petsc/petsc4py/-/issues/9
# https://github.com/dajuno/fenics-archlinux-build/issues/1
#
# Now, petsc4py is downloaded automatically by the petsc4 installer
# (--download-petsc4py). The petsc configure script runs with python2 (system) and
# requires Cython and numpy to install petsc4py.
# Install pip for python2
# python2 <(curl -L https://bootstrap.pypa.io/pip/2.7/get-pip.py) &&
# python2 -m pip install -v Cython numpy

cd "${BUILD_DIR}" &&
	wget --quiet --read-timeout=10 -nc -P tar/ "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz" &&
	tar -xzf "tar/petsc-lite-${PETSC_VERSION}.tar.gz" &&
	cd "petsc-${PETSC_VERSION}" &&
	python2 ./configure \
		--COPTFLAGS="$COPTFLAGS" \
		--CXXOPTFLAGS="$CXXOPTFLAGS" \
		--CPPFLAGS="$CPPFLAGS" \
		--FOPTFLAGS="$FOPTFLAGS" \
		--CFLAGS="$CFLAGS" \
		--CXXFLAGS="$CXXFLAGS" \
		--FFLAGS="$FFLAGS" \
		--FCFLAGS="$FCFLAGS" \
		--F90FLAGS="$F90FLAGS" \
		--F77FLAGS="$F77FLAGS" \
		--with-fortran-bindings=no \
		--with-debugging=0 \
		--download-blacs \
		--download-hypre \
		--download-metis \
		--download-parmetis \
		--download-mumps \
		--download-ptscotch \
		--download-scalapack \
		--download-spai \
		--download-suitesparse \
		--download-superlu \
		--prefix="${PREFIX}" &&
	make MAKE_NP="${BUILD_THREADS}" && make install
        # --download-petsc4py \

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi

echo
