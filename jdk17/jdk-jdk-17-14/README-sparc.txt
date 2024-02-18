he whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Some SPARC-related hunks in the main patch were removed, and have been
restored to the sparc-specific patches. In this release, to
Awt2dLibraries.gmk and c1_LIRAssembler.cpp.

jniTypes_sparc.hpp - the first 2 put_obj() variations replaced by the
changed (signature and implementation) ones from s390, the final one
removed

The lir_virtual_call opcode has been removed, so remove it from the
list of cases in src/hotspot/cpu/sparc/c1_LIRAssembler_sparc.cpp, and
from the code that references it.

In src/hotspot/share/c1/c1_GraphBuilder.cpp vtable_index has been
removed and, more importantly, is no longer used, so the SPARC hunk
that sets it has been removed. It was only run if !UseInlineCaches, so
it ties in with has_ind_br() and platform features, but on sun4v
systems it would have used this code. Need to keep an eye on
UseInlineCaches and anything else hooked into has_ind_br() for future
releases.

In src/hotspot/cpu/sparc/c1_LIRAssembler_sparc.cpp remove
vtable_call(); it's no longer used, and fails to compile due to
op->vtable_offset() being called, as vtable_offset() has been removed.
