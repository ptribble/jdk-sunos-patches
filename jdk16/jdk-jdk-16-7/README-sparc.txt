The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

The main symptom was is_simm12() undeclared, but this is a symptom of
a wider cleanup. There is a whole family of is_simmXX() helpers, and
the ones no longer used in the jdk were removed. We still use some of
them on SPARC, so they were added back in assembler-hpp.patch

A similar thing was min_simm13() which was removed. That is only used
in a small number of places, and is a constant -4096, so simply
replaced the function with the constant value.

Build failure
./src/hotspot/cpu/sparc/c1_LIRGenerator_sparc.cpp:967:53: error: no matching function for call to 'LIR_List::convert(Bytecodes::Code, LIR_Opr, LIR_OprDesc*&, bool)'
Removed the trailing false argument from those calls in
src/hotspot/cpu/sparc/c1_LIRGenerator_sparc.cpp that had it, as the
final argument appears to no longer be used (and defaulted to false in
the past anyway)

I didn't need the cpu_microcode_revision(), presumably that's only
needed on intel
