The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation. This had to be
reworked a little because some of the .inline.hpp files had the order
of their headers shuffled.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.

Implemented
8266950: Remove vestigial support for non-strict floating-point execution
Which means we are always in strictfp mode

Fallout from integration of the foreign linker API. Had to provide a
null implementation of
ForeignGlobals::parse_call_regs_impl()
ProgrammableUpcallHandler::generate_optimized_upcall_stub()
ProgrammableUpcallHandler::supports_optimized_upcalls()
and apply
0001-8266257-Fix-foreign-linker-build-issues-for-ppc-and-.patch
as a temporary fix for this build only (it was committed just after
17+25 was tagged, so will be included in later builds)
