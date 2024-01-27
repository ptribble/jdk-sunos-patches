The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

New flag UseSHA3Intrinsics. I've set it to false; it might be
available on the M8 processor but we would have to provide a check and
an implementation (if we do, look at vm_version_sparc.hpp and
ISA_sha3_msk)
