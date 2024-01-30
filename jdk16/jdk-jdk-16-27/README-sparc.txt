The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Stronger typing in vmIntrinsics requires a couple of casts

static_cast<int>(vmIntrinsics::_compiledLambdaForm)
in a cmp_and_br_short() call in interp_masm_sparc.cpp

iid becomes vmIntrinsics::as_int(iid) in a fatal() in
sharedRuntime_sparc.cpp
