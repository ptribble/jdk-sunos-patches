This is derived from the pkgsrc-joyent set for openjdk11, building on
my openjdk12 set.

All patches -p0

JDK13:
openjdk13 fixes (besides fixing line number noise)

patch-make_lib_Awt2dLibraries.gmk - first hunk already fixed

patch-make_hotspot_lib_JvmOverrideFiles.gmk
tribblix-agent-mt.patch
patch-make_lib_Lib-jdk.crypto.ucrypto.gmk
patch-make_lib_Awt2dLibraries.gmk
patch-make_hotspot_gensrc_GensrcDtrace.gmk
patch-make_hotspot_gensrc_GensrcAdlc.gmk
patch-make_hotspot_lib_CompileJvm.gmk
  $(OPENJDK_BUILD_OS) -> $(call isBuildOs, )
  $(OPENJDK_TARGET_OS) -> $(call isTargetOs, )
  and similar patterns

tribblix-flags-cflags.patch
  comment is different
  add extra patch to default to -std=gnu99 rather than c99
  
Build:

env PATH=/usr/bin:/usr/sbin:/usr/sfw/bin:/usr/gnu/bin bash ./configure \
--enable-unlimited-crypto --with-boot-jdk=/usr/jdk/instances/jdk12 \
--with-native-debug-symbols=none \
--with-toolchain-type=gcc \
--disable-hotspot-gtest --disable-dtrace \
--disable-warnings-as-errors

env PATH=/usr/bin:/usr/sbin:/usr/sfw/bin:/usr/gnu/bin gmake all
