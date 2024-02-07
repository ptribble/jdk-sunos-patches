The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

There's an extra
+#include "gc/shared/tlab_globals.hpp"
in templateTable_sparc.cpp and c1_MacroAssembler_sparc.cpp, to match
changes in other architectures like s390 and ppc

Rename log2_int() to log2i_exact() in c1_LIRGenerator_sparc.cpp and
c1_LIRAssembler_sparc.cpp, like s390. (log2_long() would have needed
the same change, but we have no usage of that one.)
