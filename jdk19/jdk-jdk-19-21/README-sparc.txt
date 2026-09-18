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

A second phase of work was also added. This was to remove the backout
of 8264868 which fiddled with the headers needed to get Register and
RegisterMap. This was reverted because it broke the build.
Unfortunately maintaining it through the upcoming changes in 19+22
(the Loom integration) proved impracticable, so fixing it proved to be
necessary. The issue you encounter is that Register isn't defined. The
blunt instrument approach ending up being to add "asm/register.hpp" to
precompiled.hpp, ensuring it gets included early enough to be
useful. (The way a lot of the cpu etc headers work is that they're
included by the main files, sometimes even in the middle or the end,
so you can't fix it locally because it's too late.) This also required
adding "register_sparc.hpp" to vm_version_sparc.hpp.

Another interesting issue that this flagged was that the FFI
integration didn't exist at all for sparc. It's unclear why this
didn't break the build earlier. This required 4 shim files to be added
  foreign_globals_sparc.cpp
  foreign_globals_sparc.hpp
  universalNativeInvoker_sparc.cpp
  universalUpcallHandle_sparc.cpp
which call Unimplemented(), just like s390.
