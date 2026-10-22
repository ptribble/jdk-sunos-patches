#!/bin/sh
#
# SPDX-License-Identifier: CDDL-1.0
#
# copies the patches from one tag to the next
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
if [ -d "${NVER}" ]; then
    bail "new version already exists"
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
# copy the entire patch directory, and create new pls file(s)
#
cp -r "${OVER}" "$NVER"

sed "s:${OVER}:${NVER}:" "${OVER}.pls" > "${NVER}.pls"
if [ -f "${OVER}.pls.solaris" ]; then
    sed "s:${OVER}:${NVER}:" "${OVER}.pls.solaris" > "${NVER}.pls.solaris"
fi
if [ -f "${OVER}.pls.sparc" ]; then
    sed "s:${OVER}:${NVER}:" "${OVER}.pls.sparc" > "${NVER}.pls.sparc"
fi
