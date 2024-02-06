The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

The release saw JEP390 land. The only relevant code it touched was the
experimental diagnostics introduced in
8242263: Diagnose synchronization on primitive wrappers
which we haven't implemented (it appeared in 16+13),
so I'm going to ignore it for now.

Klass::vtable_start_offset()
needs another include, as it's an inline
+#include "oops/klass.inline.hpp"
in sparc.ad

New function Matcher::supports_vector_variable_rotates()
needs a null implementation in sparc.ad
