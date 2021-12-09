#!/bin/sh
# Cross Compile
NAME="openldap"

if [ "$1" = "musl" ]; then
	TGT="arm-linux-musleabihf"
	MUSL="/opt/musl/${TGT}-cross"
	export PATH=$MUSL/bin:$PATH
else
	TGT="arm-linux-gnueabihf"
	# TGT="aarch64-linux-gnu"
fi

X="${TGT}-"
PREFIX=/opt/${X}${NAME}
export CC="${X}gcc"
[ ! -e $(env $CC) ] && echo "Error: $CC not found!" && exit 1
export CXX=${X}g++
export AR=${X}ar
export AS=${X}as
export LD=${X}ld
export NM=${X}nm
export STRIP=${X}strip

# Main Prog.
make distclean
LC_ALL=C \
	./configure \
	--host=$(uname -m) \
	--target=${TGT} \
	--build=${TGT} \
	--with-yielding_select=no \
	--disable-slapd \
	ac_cv_func_memcmp_working=yes
make TARGET=${TGT} depend && make TARGET=${TGT}
