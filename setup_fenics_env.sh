#!/bin/bash
set -e
source env_build.sh

echo "
# load python virtual env

source ${PREFIX}/venv/bin/activate

# remove system's petsc location from PYTHONPATH for the case where a conflicting petsc
# version was installed system wide, e.g. from AUR
export PYTHONPATH=\$(echo \${PYTHONPATH} | awk -v RS=: -v ORS=: '/\/opt\/petsc\/linux-c-opt\/lib/ {next} {print}' | sed 's/:*$//')" >>"${PREFIX}/share/dolfin/dolfin.conf"

echo "
Load FEniCS ${TAG} environment with 
    source ${PREFIX}/share/dolfin/dolfin.conf"
