#!/bin/bash
set -e
source env_build.sh

export PETSC_DIR=${PREFIX}
export BOOST_DIR=${PREFIX}

export CFLAGS="-O2 -march=native"
export CXXFLAGS="-O2 -march=native"

echo "Downloading and building mshr $MSHR_VERSION"

source ${VENV}/bin/activate

cd "$BUILD_DIR" &&
	git clone https://bitbucket.org/fenics-project/mshr.git &&
	cd mshr &&
	git checkout "$MSHR_VERSION" &&
	mkdir -p build &&
	cd build &&
	cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_SKIP_BUILD_RPATH=TRUE \
		-DCMAKE_SKIP_RPATH=TRUE \
		-DCMAKE_INSTALL_PREFIX="${PREFIX}" &&
	make -j "${BUILD_THREADS}" && make install &&
	cd ../python/ &&
	DOLFIN_DIR=$PREFIX pip -v install .

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi
