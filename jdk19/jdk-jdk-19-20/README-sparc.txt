There are a couple of changes here; sparc.ad needs an implementation of
bool Parse::do_one_bytecode_targeted()
we return false, like s390 and ppc.
And in matcher_sparc.hpp vector_op_pre_select_sz_estimate() has
changed, and there's a corresponding scalar function; again we simply
copy what looks like the default that s390 and ppc use.

Also need to add sparc-stringopts.patch to fix a build failure.
