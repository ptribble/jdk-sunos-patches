The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Some patch noise associated with replacement of NULL by nullptr

Revised many patches to handle RISCV additions

Handled the safefetch rework. Removed the is_safefetch_fault() block
entirely, matching solaris_x86. Removed the safefetch stubs from
stubGenerator_sparc.cpp. Patched
src/hotspot/share/runtime/safefetch.hpp to add SPARC to ZERO and AIX
so that we use the safe and portable sigjmp implementation

Implemented print_tos_pc(), again like solaris_x86.

Implemented LIR_Assembler::emit_load_klass(), based largely on the
change in ppc - there's a block in the T_ADDRESS case of the
LIR_Assembler::load() function in c1_LIRAssembler_sparc.cpp that was
simplified and the original largely moved to the new function.

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.
