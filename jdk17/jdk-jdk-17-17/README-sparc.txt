The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

In src/hotspot/share/opto/type.cpp a new vectormask type has been
added, updated the patch so it has the correct context and thus
doesn't fail to apply, and added the vectormask type to sparc to match
the other cpus.

While there, changed ifdef SPARC to if defined(SPARC) to match the
style.

Added Matcher::predicate_reg_mask() Matcher::predicate_reg_type() to
sparc.ad, a null implementation to match s390.

One format cleanup copied from solaris_x86.
