The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

For 15+25, the patches are applied in the regular pls file, and aren't
split out. This largely covers the following patches:

restore_cpu_sparc.patch - the src/hotspot/cpu/sparc tree
restore_os_cpu_solaris_sparc.patch - the src/hotspot/os_cpu/solaris_sparc tree
stack_bias.25.patch - restores STACK_BIAS where necessary
