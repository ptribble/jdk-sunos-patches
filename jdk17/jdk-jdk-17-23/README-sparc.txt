The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.

A number of functions and constants were moved from the .ad files into
separate matcher_cpu.hpp headers

A new file src/hotspot/cpu/aarch64/gc/g1/g1Globals_sparc.hpp to match
similar new files in other cpus, as it's required by
  #include CPU_HEADER(gc/g1/g1Globals)
in src/hotspot/share/gc/g1/g1RemSet.cpp

New code in src/hotspot/share/c1/c1_LIRGenerator.cpp called the
2-argument form of branch(),
+  __ branch(lir_cond_notEqual, L_not_prim->label());
+  __ branch(lir_cond_always, L_done->label());
On SPARC we need the 3-argument form with the type in the middle. By
comparison with other callers that pass a label(), use T_OBJECT as the
middle argument.
