The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Main fix here is to do the change of
JVM_handle_solaris_signal() -> PosixSignals::pd_hotspot_signal_handler()
just like I did on x86.

cpu/s390 and ppc remove delayed_value_impl(), we don't use it so
remove on sparc too

The UseRDPCForConstantTableBase flag was removed. This is related to
UseBlockZeroing, and the zero_aligned_words() function which has also
been removed. Simply remove code that checks for these, taking the
default branch.
