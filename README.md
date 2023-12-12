These are the (work in progress) SunOS jdk builder patches.

Here are just the patches; the actual script to drive the builds is in the
[jdk-sunos-builder](https://github.com/ptribble/jdk-sunos-builder) repository.

The patches here come originally from the jdk builds in the
[tribblix/build](https://github.com/tribblix/build) repository,
but have been modified and modernized. The issue here is that while
the patches were correct at the time, for the system (OS, compilers,
tools, etc) of the time, many of the older versions simply won't build
on current systems, so the patches have been updated in an attempt to
make the whole chain buildable.
