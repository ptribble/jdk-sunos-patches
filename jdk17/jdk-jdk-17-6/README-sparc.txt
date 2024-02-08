The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Added
#include "runtime/vm_version.hpp"
to assembler_sparc.hpp so that it can find VM_Version::
(This include was added to lots of files in ppc, none in s390, some in
x86, so it's a bit random.)

There's a change in methodHandles_sparc.cpp
-    PRESERVE_EXCEPTION_MARK; // May not be needed by safer and unexpensive here.
+    // may not be needed by safer and unexpensive here
+    PreserveExceptionMark pem(Thread::current());
to match exactly the same change in all other cpus.
