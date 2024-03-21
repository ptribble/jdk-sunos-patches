The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Signal hunk moved from os_posix.cpp to signals_posix.cpp

Tidied up the sparc hunk for src/hotspot/share/gc/g1/g1HeapRegionAttr.hpp
due to context changes

Signal rework: os_solaris_sparc.cpp gains an include
+#include "signals_posix.hpp"
and various os::Solaris:: signal functions become PosixSignals::()

Remove call to OSThread::SR_handler()

Hide the libjsig_is_loaded block.

Remove TemplateTable::pd_initialize() from templateTable_sparc.cpp

Tightening up of CompressedKlassPointers::encode, associated with
narrowKlass and narowOop now being different types, needed to convert
one return in macroAssembler_sparc.cpp from a narrowOop to a
narrowKlass, and change a CompressedOops::encode() to a
CompressedOops::narrow_oop_value()

SPARC build was originally skipped as the regular patches were broken,
now fixed.
