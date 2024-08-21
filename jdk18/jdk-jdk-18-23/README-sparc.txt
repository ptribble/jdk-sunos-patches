Changes in 18+23

In c1_LIRGenerator_sparc.cpp, 2 instances of adding an extra case
-    case vmIntrinsics::_dsqrt: {
+    case vmIntrinsics::_dsqrt:
+    case vmIntrinsics::_dsqrt_strict: {

In templateTable_sparc.cpp a couple of casts of
SharedRuntime::dtrace_object_alloc
to
static_cast<int (*)(oopDesc*)>(SharedRuntime::dtrace_object_alloc)
