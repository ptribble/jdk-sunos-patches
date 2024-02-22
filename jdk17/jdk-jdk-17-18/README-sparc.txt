he whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Removed the unused SafePointNode::needs_polling_address_input() from
sparc.ad, to match other cpus.

Two commits of interest caused problems for this build.

8264868: Reduce inclusion of registerMap.hpp and register.hpp
8265103: Remove unnecessary inclusion of oopMap.hpp

(By remove and reduce, they mean, reduce the number of files that
include these headers transitively from a common header at the top of
the tree when they don't need to, instead including them explicitly
where they're actually used, so they end up being added to a fair
number of files.)

For the second one, needed to add
#include "compiler/oopMap.hpp"
to
c1_Runtime1_sparc.cpp
sharedRuntime_sparc.cpp
frame_sparc.cpp
runtime_sparc.cpp

For the first one, it generates large numbers of build errors, which
may not be obvious but usually the root cause is that something in
Register is undeclared. As a temporary measure, backing out this patch
(0001-8264868-Reduce-inclusion-of-registerMap.hpp-and-regi.patch)
allows the build to continue and complete successfully. One of the
problems is that we make use of Register in sparc where other
platforms don't.
