Cleanup: in vm_version_solaris_sparc.cpp, moved _dl_handle to the
front of the initialization listy for PICL(), as we get a warning
"will be initialized after [-Wreorder]" otherwise.
