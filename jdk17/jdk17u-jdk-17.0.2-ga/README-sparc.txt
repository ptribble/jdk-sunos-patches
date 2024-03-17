The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Added a variable supports_encode_ascii_array to matcher_sparc.hpp
I'm not sure we need it, as sparc doesn't appear to have the
encode_iso_array() function at all.

Added sparc-linker.patch to handle the fact that the broken linker
version check is now an error rather than a warning.

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.
