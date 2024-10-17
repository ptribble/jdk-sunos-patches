#!/bin/sh
#
# SPDX-License-Identifier: CDDL-1.0
#
# rolls the solaris patches forward from one tag to the next
#
# expects 2 args - old and new tags
#
case $# in
    2)
	OVER=$1
	NVER=$2
	;;
    *)
	echo "Usage: $0 old_tag new_tag"
	exit 1
	;;
esac

bail () {
    echo "ERROR: $1"
    exit 1
}

if [ ! -d "${OVER}" ]; then
    bail "cannot find old version"
fi
if [ ! -d "${NVER}" ]; then
    bail "cannot find new version"
fi
if [ ! -f "${OVER}.pls.solaris" ]; then
    bail "old pls missing"
fi
if [ -f "${NVER}.pls.solaris" ]; then
    bail "new pls already exists"
fi

#
# it's assumed that we just have a tag, so we need to be in the
# appropriate subdirectory for a release train
#

case "${OVER}" in
    */*)
	bail "run this from the jdkXX subdirectory"
	;;
esac

case "${NVER}" in
    */*)
	bail "run this from the jdkXX subdirectory"
	;;
esac

#
# copy the patches listed in the old solaris pls file to the new
# directory, and create a new pls file referencing those copies
#
cp $(awk '{print $2}' "${OVER}.pls.solaris") "$NVER"
sed "s:${OVER}:${NVER}:" "${OVER}.pls.solaris" > "${NVER}.pls.solaris"
