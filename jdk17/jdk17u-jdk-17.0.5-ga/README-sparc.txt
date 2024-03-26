The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Implement frame::link_or_null() in frame_sparc.inline.hpp to match
other cpus. This one had been backported to jdk11, verified the
implementation we use matches that one.

Much patch noise. One of the hunks for
src/hotspot/share/c1/LIRGenerator.cpp removed - we're simply rewriting
any branch call to add an extra type argument, and the change was to
make the code branchless.

Changes to the walkable() and make_walkable() logic. I've reverted the
8282477 fix (see the original patch
0001-8282477-x86-aarch64-vmassert-_last_Java_pc-NULL-alre.patch) as it
caused crashes, even if the sparc code was aligned with it, because
tehre are assumptions on other platforms about what walkable() means
for sp and pc, whereas sparc is about register windows. I have removed
the guarantee, though, so the original bug addressed by 8282477 should
be fixed (and might fix one of the crashes seen in jdk16).

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.
