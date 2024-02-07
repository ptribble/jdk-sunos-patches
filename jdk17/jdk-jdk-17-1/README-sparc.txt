The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

The includes for stubRoutines appear to have been reworked. It looks
like it's no longer included widely but is more specific. Needed to add
#include "runtime/stubRoutines.hpp"
to c1_LIRAssembler_sparc.cpp c1_Runtime1_sparc.cpp
c2_MacroAssembler_sparc.cpp methodHandles_sparc.cpp
sharedRuntime_sparc.cpp

This then causes a problem for thread_solaris_sparc.hpp which also has
a bit of StubRoutines in it. Including the global stubRoutines.hpp
badly breaks the build all over the place; including the cpu-specific
header doesn't work as it still needs the main one.

On closer inspection, the function that uses StubRoutines there,
record_base_of_stack_pointer(), is - as far as I can tell - nowhere
used or referenced. So simply remove that function entirely.
