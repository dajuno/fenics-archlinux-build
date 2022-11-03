#!/bin/bash
set -e
source env_build.sh

export PETSC_DIR=${PREFIX}
export SLEPC_DIR=${PREFIX}

source ${VENV}/bin/activate

pip3 install -v mpi4py

git clone https://bitbucket.org/petsc/petsc4py "$BUILD_DIR/petsc4py" &&
    cd "$BUILD_DIR/petsc4py" && git checkout 3.13.0 &&
    python setup.py build && 
    python setup.py install

export PYTHONPATH=$PREFIX/lib:$PYTHONPATH

pip3 install -v slepc4py=="${SLEPC4PY_VERSION}"

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi

echo
