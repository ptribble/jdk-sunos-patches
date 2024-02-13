The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

New pd_location(VMReg base_reg, int slot_idx) added to registerMap_sparc.hpp.
Copy the implementation used on other cpus, as they were all identical.

Need to add
#include "runtime/jniHandles.hpp"
to sharedRuntime_sparc.cpp and templateInterpreterGenerator_sparc.cpp

In frame_sparc.cpp, a couple of cases of
assert(obj == NULL || Universe::heap()->is_in(obj), "sanity check");
become
assert(Universe::is_in_heap_or_null(obj), "sanity check");
just to align with other cpus.
