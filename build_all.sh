#!/bin/bash

# exit on error
set -e

# FEniCS version
#
#   This is the git branch or tag of the dolfin version to be installed.
#   Currently available:
#       * master            (development version)
#       * 2019.1.0.post0    (last stable build)
#
#   As new releases become available, build_fenics_pymodules.py must be modified to support them.
export FENICS_VERSION="master"

# Dependency versions
export PETSC_VERSION=3.13.2
export SLEPC_VERSION=3.13.3
export PETSC4PY_VERSION=3.13.0
export SLEPC4PY_VERSION=3.13.0
export MSHR_VERSION=2019.1.0

# $TAG specifies the name of the build directories and the virtualenv
# *** NOTE: modify this to change the installation path!
# $TAG is arbitrary. date is useful for development build
DATE=$(date +%F)
export TAG="${FENICS_VERSION}-${DATE}_new"

export BUILD_THREADS=2
export PREFIX=${HOME}/work/dev/fenics-${TAG}
export BUILD_DIR=${HOME}/work/dev/build/fenics-${TAG}
mkdir -p "${PREFIX}" "${BUILD_DIR}"

export VENV=${PREFIX}/venv

# set this to true in order to wait after each module
export CONTINUE_ON_KEY=false

echo "Installing FEniCS to ${PREFIX}"

# comment to disable installation of a component
./setup_virtualenv.sh
./build_boost.sh
./build_petsc.sh
./build_slepc.sh
./build_python_modules.sh
./build_fenics_pymodules.sh # ffc fiat ufl uflacs instant
./build_dolfin.sh
./build_mshr.sh
./setup_fenics_env.sh

# run with $ ./build_all.sh |& tee -a build.log
