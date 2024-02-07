The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

UseStackBanging is removed and is now the default, so force to true,
like other cpu platforms. (3 of the 4 cases have this inside an ASSERT
block, so only one case is relevant to regular use.)
