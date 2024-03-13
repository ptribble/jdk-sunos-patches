The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

In sparc.ad, remove the following functions to match other
architectures:
Matcher::pd_implicit_null_fixup
interpreter_method_reg
interpreter_method_regP

Also add a no-op implementation like s390 of
Matcher::supports_vector_variable_shifts()

In os_solaris_sparc.cpp, delete SignalHandlerMark (just like x86 had
already)

Compiling sharedRuntime_sparc.cpp complains that
error: 'class nmethod' has no member named 'set_lazy_critical_native'
the whole area of handling is_critical_native has been redone.
First, remove save_or_restore_arguments() and
check_needs_gc_for_critical_native(), and the call to
check_needs_gc_for_critical_native()
Then mirror the code shuffling that was performed on ppc and s390.
Finally there was a new assembler section. Looking at s390 and others,
the new hunk largely duplicates another hunk. Found the corresponding
other hunk in the sparc code, and copied it the same way, changing the
variable names
