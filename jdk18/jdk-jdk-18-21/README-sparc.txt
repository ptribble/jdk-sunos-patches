Changes in 18+21

In src/hotspot/share/gc/g1/g1HeapRegionAttr.hpp, needs_remset_update
has been renamed to remset_is_tracked

In prefetch_solaris_sparc.inline.hpp, Prefetch::read() first argument
becomes const. And tidy up the Studio junk here, like x86 was at this
point.
