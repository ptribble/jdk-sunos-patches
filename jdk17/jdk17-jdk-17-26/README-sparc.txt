The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

Note that
8264868: Reduce inclusion of registerMap.hpp and register.hpp
is still temporarily backed out pending investigation.

The main java-solaris-sparc.patch was originally cleaned up in 17+20
to remove a lot of sparc remnants, so these have been added back.

Quite a lot of patch noise due to additional vector code.

Null implementations of

SharedRuntime::vector_calling_convention() in sharedRuntime_sparc.cpp
Matcher::supports_vector_calling_convention() in sparc.ad
Matcher::vector_return_value() in sparc.ad
supports_vector_comparison_unsigned() in matcher_sparc.hpp

In the 0048-8256205-Simplify-compiler-calling-convention-handlin.patch
patch, need to remove the first hunk for src/hotspot/share/opto/callnode.cpp
which removed #include "runtime/sharedRuntime.hpp", as callnode.cpp
now uses SharedRuntime for the vector stuff.
