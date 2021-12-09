#!/bin/sh
# Cross Compile
NAME="adtool"

# For musl
# Assume your host is x86_64 Linux System
# Download Cross Compile Binary from
# https://more.musl.cc/x86_64-linux-musl/
# Select the proper tgz file for your target
# Assume you uncompress tgz to $MUSL dir

# For Non-musl
# On Ubuntu System you just install one or all of the crossbuild-essential package
# Select your target in the output of "apt list|grep ^crossbuild-essential"

LDAP_DIR=$PWD/../openldap-2.5.9/libraries
LDFLAGS="-L${LDAP_DIR}/liblber -L${LDAP_DIR}/libldap -L${LDAP_DIR}/libwrite"

if [ "$1" = "musl" ]; then
	TGT="arm-linux-musleabihf"
	MUSL="/opt/musl/${TGT}-cross"
	export PATH=$MUSL/bin:$PATH
	LDFLAGS="$LDFLAGS --static"
	export CC="${TGT}-gcc"
	export CC="$CC -I ${LDAP_DIR}/../include $LDFLAGS"
else
	# Non-musl
	# TGT="aarch64-linux-gnu"
	TGT="arm-linux-gnueabihf"
	export CC=${TGT}-gcc
	export CC="$CC $LDFLAGS"
fi

X="${TGT}-"
# Assume you plan install to $PREFIX
PREFIX=/opt/${X}${NAME}

# Compile Vars
export CXX=${X}g++
export LD=${X}ld
export AR=${X}ar
export AS=${X}as
export NM=${X}nm
export STRIP="${X}strip"
export STRIPPROG="${X}strip"
[ ! -e $(env $CXX) ] && echo "Error: $CXX Not found!" && exit 1

# Main.
make distclean
./configure --prefix=${PREFIX} \
	--host=$(uname -m) \
	--build=${TGT} \
	--target=${TGT} \
	--disable-dependency-tracking \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes
make TARGET=${TGT} && sudo make TARGET=${TGT} install
