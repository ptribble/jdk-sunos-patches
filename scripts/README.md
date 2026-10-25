The scripts here help maintain the patches in this repository

sync-build.sh

The primary source of patches for a given tag is the tribblix/build
repo. Run this script to copy any new tags.

copy-sparc-patches.sh

This is part of the SPARC porting effort. You'll always have the x86
patches thanks to syncing from the build repo as above. But once you've
got one tag ported to SPARC, use this script to copy the patches from
the tag you've just done to the next tag as a starting point.

copy-solaris-patches.sh

The extra patches for Solaris aren't present in the build repo, so this
will copy them from one tag to the next.

copy-linux-patches.sh

The extra patches for Linux aren't present in the build repo, so this
will copy them from one tag to the next.

copy-tag.sh

This copies the patches from one tag to another, which handles any cases
where the tag isn't present in the build repo.

verify-patches.sh

This script checks the patches and the patch lists are consistent. You can
ignore any warnings in 15+24 associated with the point of removal.
