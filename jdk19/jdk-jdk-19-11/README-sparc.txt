The file src/utils/hsdis/hsdis.c has been renamed (just rename, no change)
to src/utils/hsdis/binutils/hsdis-binutils.c

In hotspot/cpu, all of the files register_definitions_foo.cpp have
simply been removed. Remove the sparc one, because if we don't the
build fails on it.
