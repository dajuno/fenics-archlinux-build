#!/bin/bash
source env_build.sh "$ARCH"

mkdir -p "${BUILD_DIR}/tar"

cd "${BUILD_DIR}" &&
	wget --quiet --read-timeout=10 -nc http://sourceforge.net/projects/boost/files/boost/1.73.0/boost_1_73_0.tar.gz/download -O tar/boost.tar.gz &&
	tar -xf tar/boost.tar.gz &&
	cd boost_1_73_0 &&
	./bootstrap.sh --prefix="$PREFIX" --with-libraries=filesystem,program_options,system,thread,timer,iostreams,regex &&
	./b2 install

if [ "$CONTINUE_ON_KEY" = true ]; then
	echo "Press any key to continue..."
	read -r -n 1
fi

echo
