The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

The original patches here were bad and needed to be regenerated
cleanly.

Remove the methodhandles patch because it duplicates the #undef CS
that, as of 16+12, is handled in the main patch.

There are new functions
  Matcher::supports_scalable_vector()
  Matcher::scalable_vector_reg_size(BasicType)
We need to implement. This looks like something new for aarch64 -
there's a lot of SVE stuff added there. Add null implementations like
s390 that return false and -1 respectively.

There's a SEGV in Matcher::regmask_for_ideal_register()
The change here is that there's a new ideal_register type, Op_VecA
that should only do anything on aarch64.
Add Op_VecA to the bad list in src/hotspot/share/opto/type.cpp for
SPARC (this was also done for s390 and ppc in 16+16, which confirms
the fix was correct).
