Needed to handle the vm_version rework.
Moved initialize_cpu_information() from vm_version_ext_sparc to
vm_version_sparc, the function in the cpp and the signature in the
hpp file. Added in the necessary defines and includes to make it
work.
Removed vm_version_ext_sparc.{cpp,hpp}
