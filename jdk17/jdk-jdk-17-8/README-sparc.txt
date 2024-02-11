The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Significant refactoring as a result of
8251462: Simplify compilation policy
which was all around tiered compilation. Mostly mechanical changes.

Removed the patch for the removed file
src/hotspot/share/compiler/tieredThresholdPolicy.cpp, the hunk was
reimplemented for src/hotspot/share/compiler/compilerDefinitions.cpp

Updated patching of src/hotspot/share/opto/generateOptoStub.cpp due to
a context change NULL -> control(), and we need the same for the patch
we added.

Checking for TIERED needs to be replaced, looking at the other cpus to
see what the correct replacement is
src/hotspot/cpu/sparc/c1_globals_sparc.hpp
  #ifndef TIERED -> #ifndef COMPILER2
src/hotspot/cpu/sparc/c2_globals_sparc.hpp
  the TieredCompilation line
  trueInTiered -> COMPILER1_PRESENT(true) NOT_COMPILER1(false)
src/hotspot/cpu/sparc/templateInterpreterGenerator_sparc.cpp
  generate_counter_incr signature change, drop last 2 args
    (those 2 args are to do with profiling)
  basically take the if(TieredCompilation) path, lose an indent
  a couple of places guarded by if(ProfileInterpreter) removed
src/hotspot/cpu/sparc/templateTable_sparc.cpp
  basically take the if(TieredCompilation) path, lose an indent
src/hotspot/cpu/sparc/globals_sparc.hpp
  TIERED_ONLY -> COMPILER1_AND_COMPILER2_PRESENT
src/hotspot/cpu/sparc/globalDefinitions_sparc.hpp
  #if defined(TIERED) -> #if COMPILER1_AND_COMPILER2
src/hotspot/os_cpu/solaris_sparc/os_solaris_sparc.cpp
  #ifdef TIERED -> #if COMPILER1_AND_COMPILER2

There was also some SystemDictionary cleanup:

Remove #include "classfile/systemDictionary.hpp" from
c1_macroassebler_sparc.cpp runtime_sparc.cpp

Add #include "classfile/vmClasses.hpp" to
methodHandles_sparc.cpp
and similar changes to code as for s390
generally, systemdictionary -> vmclass
and code changes in methodHandles_sparc.hpp

Add #include "runtime/signature.hpp" to
sharedRuntime_sparc.cpp

In src/hotspot/cpu/sparc/interp_masm_sparc.cpp, remove the functions
InterpreterMacroAssembler::test_invocation_counter_for_mdp() and
InterpreterMacroAssembler::test_backedge_count_for_osr() which were
also removed in ppc, which are unused, and call code that no longer
exists.
