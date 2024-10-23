Cleanup: in vm_version_solaris_sparc.cpp, moved _dl_handle to the
front of the initialization list for PICL(), as we get a warning
"will be initialized after [-Wreorder]" otherwise.

Cleanup: in frame_sparc.cpp, moved _deopt_state up 1 in the
initialization list for frame::frame to avoid the Wreoder warning.
