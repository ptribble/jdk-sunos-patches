The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

In thread_solaris_x86.hpp, we had to remove last_Java_fp and
set_last_Java_fp, but those don't exist on sparc so nothing to do.

From s390, need to implement the 2 call_VM -> call_VM_leaf changes

And add the Address(Register base, ByteSize disp) : change
And the other removals of ASSERT for the ByteSize -> int change

SPARC build was originally skipped as the regular patches were broken,
now fixed.
