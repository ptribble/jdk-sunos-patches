The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

In solaris_sparc, remove MetaspaceShared::is_in_trampoline_frame()
from thread_solaris_sparc.cpp, to match the change in solaris_x86.

Remove the functions
SharedRuntime::trampoline_size()
SharedRuntime::generate_trampoline()
from sharedRuntime_sparc.cpp, to align with other platforms.
