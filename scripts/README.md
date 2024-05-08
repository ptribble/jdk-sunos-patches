The scripts here help maintain the patches in this repository

sync-build.sh

The primary source of patches for a given tag is the tribblix/build
repo. Run this script to copy any new tags.

(You'll have to `git clean -f jdk12 jdk14` each time, to avoid noise.)

copy-sparc-patches.sh

This is part of the SPARC porting effort. You'll always have the x86
patches thanks to syncing from the build repo as above. But once you've
got one tag ported to SPARC, use this script to copy the patches from
the tag you've just done to the next tag as a starting point.

verify-patches.sh

This script checks the patches and the patch lists are consistent. You can
ignore any warnings in 15+24 associated with the point of removal.
