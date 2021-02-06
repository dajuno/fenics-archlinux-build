#!/bin/bash
set -e

source env_build.sh

export PETSC_DIR=${PREFIX}
export SLEPC_DIR=${PREFIX}
# # PETSc is found automatically, SLEPc not
# export SLEPC_DIR=/usr/local/slepc/linux-c-opt/
export BOOST_DIR=${PREFIX} 

echo "Downloading and building dolfin ${FENICS_VERSION}"

source $VENV/bin/activate

patch_dir=$PWD

cd $BUILD_DIR && \
    git clone https://bitbucket.org/fenics-project/dolfin.git && \
    cd dolfin && \
    git checkout ${FENICS_VERSION} && \
    patch -p0 --verbose < ${patch_dir}/dolfin_hdf5-112.patch && \
    patch -p0 --verbose < ${patch_dir}/dolfin_no-version-lock-pybind11.patch && \
    patch -p1 --verbose < ${patch_dir}/dolfin_add-missing-algorithm-include-for-std-min_element-co.patch && \
    patch -p1 --verbose < ${patch_dir}/dolfin_Use-__BYTE_ORDER__-instead-of-removed-Boost-endian.h.patch && \
    mkdir -p build && \
    cd build && \
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_BUILD_TYPE="Release" \
        -DBoost_INCLUDE_DIR=${PREFIX}/include \
        -DBoost_LIBRARY_DIR_RELEASE=${PREFIX}/lib \
        -DMETIS_LIBRARY=${PREFIX}/lib/libmetis.so \
        -DPARMETIS_LIBRARY=${PREFIX}/lib/libparmetis.so \
        -DPARMETIS_INCLUDE_DIRS=${PREFIX}/include \
        -DPTSCOTCH_LIBRARY=${PREFIX}/lib/libptscotch.a \
        -DSCOTCH_LIBRARY=${PREFIX}/lib/libscotch.a \
        -DSCOTCH_INCLUDE_DIRS=${PREFIX}/include \
        -DAMD_LIBRARIES=${PREFIX}/lib/libamd.so \
        -DAMD_INCLUDE_DIRS=${PREFIX}/include \
        -DCAMD_LIBRARY=${PREFIX}/lib/libcamd.so \
        -DCCOLAMD_LIBRARY=${PREFIX}/lib/libccolamd.so \
        -DCOLAMD_LIBRARY=${PREFIX}/lib/libcolamd.so \
        -DCHOLMOD_LIBRARY=${PREFIX}/lib/libcholmod.so \
        -DCHOLMOD_INCLUDE_DIRS=${PREFIX}/include \
        -DUMFPACK_LIBRARY=${PREFIX}/lib/libumfpack.so \
        -DUMFPACK_INCLUDE_DIRS=${PREFIX}/include \
        -DSUITESPARSECONFIG_LIBRARY=${PREFIX}/lib/libsuitesparseconfig.so \
    2>&1 | tee cmake.log && \
    make -j ${BUILD_THREADS} &&  make install && \
    cd $BUILD_DIR/dolfin/python && \
    DOLFIN_DIR=${PREFIX} pip3 -v install .


if [ "$continue_on_key" = true ]; then
    echo "Press any key to continue..."
    read -n 1
fi
