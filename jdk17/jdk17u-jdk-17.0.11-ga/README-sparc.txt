The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Additionally reverted 8268702 (and 2 subsequent commits 8270491 and
8283520 so it would revert). This caused a SEGV in
JfrJavaSupport::get_field() if you run tomcat (or anything similar
that invokes the management APIs, I expect). The stack from the crash
we see is actually similar to 8270491, but reverting these seems the
simplest way of fixing the problem.

The problem was introduced in 17+28, so the same solution could be
applied all the way back to that build.
