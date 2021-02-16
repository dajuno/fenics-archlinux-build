#!/bin/bash
set -e
source env_build.sh

echo "
# load python virtual env

source ${PREFIX}/venv/bin/activate" >>"${PREFIX}/share/dolfin/dolfin.conf"

echo "
Load FEniCS ${TAG} environment with 
    source ${PREFIX}/share/dolfin/dolfin.conf"
