In bytes_sparc.hpp and jniTypes_sparc.hpp (not barrierSetAssembler)
need to change one of the includes like so:
-#include "memory/allocation.hpp"
+#include "memory/allStatic.hpp"

Several cpus including s390 have switched supports_encode_ascii_array
from false to true, and provided an encode_ascii_array()
implementation. I *think* we can safely keep the boolean as false and
not provide an implementation and all the supporting chicanery, but it
might be assumed later that every platform does it.
