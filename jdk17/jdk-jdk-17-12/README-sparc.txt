The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Remove MetaspaceSize from c1_globals_sparc.hpp and
c2_globals_sparc.hpp as it's been removed everywhere else.

In sharedRuntime_sparc.cpp, make_native_invoker is now a RuntimeStub*
not a BufferBlob*, and guarded by #ifdef COMPILER2
