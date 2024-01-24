The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Some places where STACK_BIAS isn't defined. We had to so some patching
on x86 for getStackBias() which was cleaned up in this version, so we
no longer need the old illumos-port-7.patch. There was also some
STACK_BIAS fixes in the old illumos-port-6.patch, any still necessary
have been merged into stack_bias.25.patch.
