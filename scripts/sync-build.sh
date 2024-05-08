#!/bin/sh
#
# this script will add current/new tags to the jdk-sunos-patches repo
#
# the method is to look at my Tribblix build repo, and if there are
# any jdk pls files in that repo that are not present here, copy the pls
# file and the patches for that tag
#
BUILDREPO=${THOME}/build
NEWREPO=${THOME}/jdk-sunos-patches

bail() {
    echo "ERROR: $1"
    exit 1
}

if [ ! -d "${BUILDREPO}" ]; then
    bail "No source repo"
fi

if [ ! -d "${NEWREPO}" ]; then
    bail "No destination repo"
fi

cd "${BUILDREPO}" || bail "cd failed"

#
# extract the jdk version, the string will either start jdk-jdk for mainline
# or jdkXX for the initial release, or jdkXXu for when it's in an update
# train
#
# for mainline, we have to pull the version from the remainder of the string
# which will look like jdk-jdk-XX-Y or jdk-jdk-XX+Y
#
major_java_version() {
    jstr=$1
    jver=${jstr%%-*}
    case $jver in
	jdk*u)
	    jver=${jver//u}
	    ;;
	jdk)
	    case $jstr in
		jdk*+*)
		    iver=${jstr%+*}
		    ;;
		*)
		    iver=${jstr%-*}
		    ;;
	    esac
	    iver=${iver##*-}
	    jver=jdk$iver
	    ;;
	jdk*)
	    :
	    ;;
	*)
	    jver=INVALID
	    ;;
	esac
    echo "$jver"
}

#
# this is what we run on each commit to create the copy
#
copy_patches() {
    cd patches || bail "cd to patches failed"
    for file in jdk*pls
    do
	if [ ! -f "$file" ]; then
	    echo "All done"
	    exit 0
	fi
	jver=${file%%.pls}
	mver=$(major_java_version "$jver")
	echo "$mver $jver $file"
	if [ ! -d "${NEWREPO}/${mver}" ]; then
	    mkdir -p "${NEWREPO}/${mver}"
	fi
	if [ ! -f "${NEWREPO}/${mver}/${file}" ] ; then
	    sed "s:open${mver}/:${jver}/:" "$file" > "${NEWREPO}/${mver}/${file}"
	    mkdir -p "${NEWREPO}/${mver}/${jver}"
	    cp "open${mver}"/* "${NEWREPO}/${mver}/${jver}"
	    if [ -f "${NEWREPO}/${mver}/${jver}/README.txt" ]; then
		echo "#!/bin/sh" > "${NEWREPO}/${mver}/${jver}/build.sh"
		awk '/.\/configure/,/gmake/' "${NEWREPO}/${mver}/${jver}/README.txt" | sed '/with-jobs/d' >> "${NEWREPO}/${mver}/${jver}/build.sh"
		chmod a+x "${NEWREPO}/${mver}/${jver}/build.sh"
	    fi
	fi
    done
    cd "${BUILDREPO}" || bail "cd failed"
}

copy_patches
