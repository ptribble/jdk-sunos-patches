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
to remove a lot of sparc remnants, so these have been added back. It's
easier to put them back there for now than apply patches over patches,
especially in the middle of all the other churn, but this will need
doing every build until it's done properly. In this build, 2 isolated
hunks moved to sparc-misc.patch.

One of the hunks for src/hotspot/share/c1/c1_LIRGenerator.cpp had to
be reworked.

Note: There's hunk in sparc-misc.patch for
src/hotspot/share/jvmci/vmStructs_jvmci.cpp regarding cpu features
that appears to have been reworked on other platforms in 17+20, moved
to the enum Feature_Flag in vm_version_$CPU.hpp. But that's all
implemented quite differently between cpus and types of flags. Ignored
for now.
