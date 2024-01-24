The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

There was a lot of additional cleanup to remove SPARC remnants.

c1.patch - restoring #ifdefs, adding back LIR_OpBranch type

sparc-bitness.patch - so it knows we're 64-bit

A number of foo_offset_in_bytes() become foo_offset()

LIRFillDelaySlots removed, replace with true

src/hotspot/share/jfr/utilities/jfrBigEndian.hpp:108:4:
warning: #warning "Unconfigured platform
See jfr-sparc.patch

memset_with_concurrent_readers redefined
Now, the original had hand-rolled assembler for sparc and the normal
memset was used everywhere else. Now the guard has been removed so we
hit the conflict. Simplest is to simply revert the change to
src/hotspot/share/gc/shared/memset_with_concurrent_readers.hpp
and leave an investigation of whether we *actually* need the assembler
instead of the library memset until later. Created memset-sparc.patch

save_native_result() and restore_native_result() undeclared
This is for TemplateInterpreterGenerator, and only existed on sparc,
so got wiped from the central header
see TemplateInterpreterGenerator-sparc.patch

os_posix.cpp has some SPARC ADI signals we need to keep

One thing about SPARC is that it requires alignment; if you have the
JVM crash with SIGBUS you've probably hit an alignment error. See
sparc-misc.patch for fixes for that.

The sparc-misc.patch file also fixes up medialib.

It's unclear exactly how much of sparc-misc.patch is actually
necessary. That's left for future work.
