#!/bin/bash
set -e
source env_build.sh

export PETSC_DIR=${PREFIX}
export SLEPC_DIR=${PREFIX}

# hide petsc system library
export PYTHONPATH=$(echo ${PYTHONPATH} | awk -v RS=: -v ORS=: '/\/opt\/petsc\/linux-c-opt\/lib/ {next} {print}' | sed 's/:*$//')

source ${VENV}/bin/activate

pip3 install -v mpi4py
echo

git clone https://bitbucket.org/petsc/petsc4py "$BUILD_DIR/petsc4py" &&
    cd "$BUILD_DIR/petsc4py" && git checkout 3.13.0 &&
    python setup.py build &&
    python setup.py install

echo

git clone https://gitlab.com/slepc/slepc4py "$BUILD_DIR/slepc4py" &&
    cd "$BUILD_DIR/slepc4py" && git checkout 3.13.0 &&
    python setup.py build &&
    python setup.py install

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi

echo
