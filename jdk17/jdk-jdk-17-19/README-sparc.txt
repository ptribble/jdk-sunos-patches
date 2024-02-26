he whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

As of this release, jdk16 is required as the boot jdk, and several
crashes of jdk16 (running the sjavac server) have been observed.

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The files depChecker_sparc.hpp and depChecker_sparc.cpp removed,
they're empty and were removed on other cpus as well.

In src/hotspot/cpu/sparc/interpreterRT_sparc.cpp, the JRT_ENTRY macro
needs to use JavaThread* current, not JavaThread* thread, because
that's what the code that uses this macro is expecting.

Added an extra include
#include "interpreter/bytecodeHistogram.hpp"
to src/hotspot/cpu/sparc/macroAssembler_sparc.cpp, otherwise build
fails with 'BytecodeCounter' has not been declared.
