The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

TOWARDS_LOW was removed globally, so removed
  // What direction does stack grow in (assumed to be same for C & Java)
  stack_direction(TOWARDS_LOW);
from src/hotspot/cpu/sparc/sparc.ad

Fix ARCH_FLAGS in src/hotspot/cpu/sparc/globals_sparc.hpp to remove
diagnostic and experimental, otherwise we get a length mismatch all
over the place.

A couple of method renames in the .ad files we need to mirror
compiler_method_oop_reg -> compiler_method_reg [not in sparc at all]
interpreter_method_oop_reg -> interpreter_method_reg
(if you don't do this, you see a warning
":Using obsolete Token, interpreter_method_oop_reg"
so that type of warning is diagnostic of some rename having taken
place.)

The function in sparc.ad
Matcher::regnum_to_fpu_offset() has been removed. As far as I can tell
it's no longer called. And wasn't in 16+15, so has been generally tidied
up. And it's safe to remove, so do so.
