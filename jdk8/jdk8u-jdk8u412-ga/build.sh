#!/bin/sh
#
env PATH=/usr/gnu/bin:/usr/bin:/usr/sfw/bin  bash ./configure \
--with-milestone=fcs --with-update-version=412 --with-build-number=b08 \
--enable-unlimited-crypto --with-boot-jdk=/usr/jdk/instances/jdk1.8.0 \
--with-toolchain-type=gcc \
--with-native-debug-symbols=none

case $(uname -p) in
    i386)
	env PATH=/usr/gnu/bin:/usr/bin:/usr/sfw/bin gmake all USE_GCC=1 AS=/usr/gnu/bin/as
	;;
    sparc)
	env PATH=/usr/gnu/bin:/usr/bin:/usr/sfw/bin HOTSPOT_DISABLE_DTRACE_PROBES=true gmake all USE_GCC=1 ASFLAGS=-m64 
	;;
esac
