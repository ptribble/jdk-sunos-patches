The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

OrderAccess::cross_modify_fence()
is now
OrderAccess::cross_modify_fence_impl()

os::Solaris::ucontext_set_pc
is now
os::Posix::ucontext_set_pc
and the get variant as well

The big change here is the incoming Foreign Linker API. Changes to
existing files have been merged into the cpu restore patch, new files
have been added via 8254231-for-sparc.patch
There are also a couple of places in methodHandles_sparc.cpp to handle
the new _linkToNative intrinsic.
In all this I've adopted the Unimplemented stubs like s390.
