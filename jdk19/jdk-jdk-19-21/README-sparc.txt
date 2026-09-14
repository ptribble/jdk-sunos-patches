The easy change here is

In c1_LIRGenerator_sparc.cpp, load_immediate() changes its first
argument to a long with a cast required below.

The complex one is:

In javaFrameAnchor_sparc.{c,h}pp

make_walkable() has lost its argument
make_walkeable() itself changed implementation
capture_last_Java_pc() removed as part of this, effectively inlined
callers of capture_last_Java_pc() reworked to use make_walkable()

The initial code rework here was just rearrangement. This failed with

#  Internal Error (frame_sparc.cpp:640), pid=8504, tid=3
#  guarantee(_post_Java_sp != NULL) failed: bad stack!

That's part of the old capture_last_Java_pc() that's now inlined into
make_walkable. I *think* it's about whether things get flushed. Note
that the sparc implementation of walkable() is simply whether
registers have been flushed, rather than looking for valid sp and pc
like the other platforms do.

The kludge used is to handle the _post_Java_sp == NULL case and return
without making the stack walkable, flushing registers, or setting
_last_java_pc. This relies on callers doing the right thing, and seems
to work.
