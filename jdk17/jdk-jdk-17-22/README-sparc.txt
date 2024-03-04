The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.

Removed unused Compile::reshape_address() like other cpus.

There was major rework of src/hotspot/share/runtime/sharedRuntime.cpp
in this build.

Dropped the patch to
src/jdk.hotspot.agent/share/classes/sun/jvm/hotspot/gc/z/ZAddress.java
as it does not and can not apply. This may need revisiting later.
