PrefetchFieldsAhead (in VM_Version) has been deprecated, and removed
from x86 which is the only other place it was present, and I can't see
any reference to it. Remove, and the associated prefetch_fields_ahead(),
from vm_version_sparc.{c,h}pp.
