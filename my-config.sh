#!/bin/sh
# Cross Compile
PREFIX=/opt/adtool-build
MYCC=aarch64-linux-gnu-gcc
MYCXX=aarch64-linux-gnu-g++
MYTGT=aarch64
MYHOME=$HOME
LDAP_DIR=${MYHOME}/github/adtool/openldap-2.5.9
MYLIBS=${LDAP_DIR}/libraries
# liblber:${MYHOME}/github/adtool/openldap-2.6.0/libraries/libldap

build_openldap() {
	pushd
	cd $LDAP_DIR
	LC_ALL=C \
		./configure \
		--host=$(uname -m) \
		--target=${MYTGT} \
		--with-yielding_select=no \
		--with-ldap=ldap \
		ac_cv_func_memcmp_working=yes \
		CC=aarch64-linux-gnu-gcc \
		CXX=aarch64-linux-gnu-g++ &&
		make depend &&
		make
	popd
	# No need to do make install
}

make distclean ||
	CONFIG_SHELL=/bin/bash \
		./configure --prefix=${PREFIX} \
		--host=$(uname -m) \
		--target=${MYTGT} \
		--with-gnu-ld \
		--disable-dependency-tracking \
		LDFLAGS="-L${MYLIBS}/liblber -L${MYLIBS}/libldap -L${MYLIBS}/libldap_r" \
		CC="${MYCC}" CXX="${MYCXX}" \
		ac_cv_func_malloc_0_nonnull=yes \
		ac_cv_func_realloc_0_nonnull=yes
# Above two ac lines to fix: "Undefined reference to rpl_malloc"
# After build openldap, copy the library libldap to libldap_r and change the filenames begin with ldap and libldap, with ldap_r and libldap_r, need to change the files in .lib as well
