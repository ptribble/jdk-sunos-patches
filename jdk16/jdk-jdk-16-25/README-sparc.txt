The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Reverted
8256238: Remove Matcher::pass_original_key_for_aes
See 0011-8256238-Remove-Matcher-pass_original_key_for_aes.patch
This should be cleaned up and reimplemented to simply use #ifdef SPARC
rather than adding a function to the architecture definition.

Reverted
8256205: Simplify compiler calling convention handling
0048-8256205-Simplify-compiler-calling-convention-handlin.patch
This is absolutely necessary, as SPARC does have a different calling
convention, in particular it uses different registers depending on
which way the call is going (based on the is_outgoing boolean).
Part of this, the move of in_preserve_stack_slots, could be taken.
And we don't need is_outgoing for c_return_value() because it's always
outgoing, but we do for return_value(). [I've tested simply removing
the is_outgoing switch for return_value and the jvm crashes whichever
way I choose.] Some of this could probably be pared back later.

Added
#include "prims/jvmtiExport.hpp"
to templateTable methodHandles jniFastGetField

There's a new function LIRGenerator::do_getObjectSize(), added the
type argument to the branch call there.

In sparc.ad, added castLL. This was added in all other cpus, and in
every case is the same as castII with I replaced by L, so do the same
here.
