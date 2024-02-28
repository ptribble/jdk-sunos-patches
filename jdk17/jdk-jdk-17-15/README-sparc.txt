The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Other than patch noise, a single change to relocInfo_sparc.cpp to
change an instance of (oop)x to cast_to_oop(x), to align with the same
systematic change applied to other cpus.
