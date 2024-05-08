#!/bin/sh
#
# verifies that the patches and patchlists are consistent and make sense
#

THOME=${THOME:-/packages/localsrc/Tribblix}
JDIR=${THOME}/jdk-sunos-patches

bail () {
    echo "ERROR: $1"
    exit 1
}

if [ ! -d "${JDIR}" ]; then
    bail "Unable to find repo"
fi

cd "${JDIR}" || bail "unable to cd"

#
# every patch mentioned in a pls file should be present
#
echo "Checking pls consistency"
for rev in jdk*
do
    echo "  Checking $rev"
    cd "$rev" || bail "cd failed"
    #
    # the key check, extract the list of patches from the pls
    # file(s) and check they all exist
    #
    for file in *.pls*
    do
	#echo "Checking $file"
	for nfile in $(awk '{print $2}' "$file")
	do
	    if [ ! -f "${nfile}" ]; then
		echo "ERROR: missing ${nfile} in ${file}"
	    fi
	done
    done
    #
    # the opposite way, every patch should be referenced in a pls file
    # this one is much more heuristic
    # and for older versions the zero patches were separate
    # so we currently ignore extra zero patches
    #
    for file in *
    do
	if [ -d "${file}" ]; then
	    if [ ! -f "${file}.pls" ]; then
		echo "ERROR: directory $file has no patchlist"
	    else
		NP1=$(cat "${file}".pls*|wc -l)
		NP2=$(ls -1 "${file}"/*patch*|grep -v zero|wc -l)
		if [ "$NP2" -gt "$NP1" ]; then
		    echo "WARN: extra patch files in $file"
		    (awk '{print $2}' "${file}".pls*;ls -1 "${file}"/*patch*|grep -v zero)|sort |uniq -u
		fi
	    fi
	fi
    done
    cd ..
done

#
# we should never list a patch more than once
# this would usually indicate an error in creating the pls files
#
echo "Checking for duplication"
for rev in jdk*
do
    echo "  Checking $rev"
    cd "$rev" || bail "cannot cd to $rev"
    cat jdk*.pls* | sort | uniq -d
    cd ..
done

#
# patch lists should never have trailing spaces
#
echo "Checking for trailing spaces in patch lists"
grep -l ' $' jdk*/*.pls*

#
# every line in a patch list should have exactly 2 fields
# and start with -p
#
echo "Checking for patch lists with incorrect entries"
awk 'NF != 2 {print}' jdk*/*.pls*
grep -v '^-p' jdk*/*.pls*

#
# if it exists, check the mainstream repo
#
if [ -d "$THOME/build/patches" ]; then
    echo "Now checking main build repo"
    cd "$THOME/build/patches" || bail "unable to cd to tribblix/build"
    echo "  Checking for duplication"
    # openjdk8 has multiple versions
    cat jdk*.pls* | sort | grep -v openjdk8 | uniq -d
    echo "  Checking for missing patches"
    for file in jdk*.pls*
    do
	#echo "Checking $file"
	for nfile in $(awk '{print $2}' "$file")
	do
	    if [ ! -f "${nfile}" ]; then
		echo "ERROR: missing ${nfile} in ${file}"
	    fi
	done
    done
    echo "  Checking for unreferenced patches"
    (awk '{print $2}' jdk*.pls*;ls -1 openjdk*/*patch*)|sort |uniq -u
fi
