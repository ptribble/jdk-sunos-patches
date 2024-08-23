Changes in 18+23

Some minor changes:

In sparc.ad, add a null function:
Matcher::match_rule_supported_vector_masked()

In c1_CodeStubs_sparc.cppm in the RangeCheckStub::RangeCheckStub() function,
_array(NULL) loses the argument and becomes _array()

In c1_FrameMap_sparc.cpp, a similar initilization change
+LIR_Opr FrameMap::_caller_save_cpu_regs[] = { 0, };
+LIR_Opr FrameMap::_caller_save_fpu_regs[] = { 0, };
  becomes
+LIR_Opr FrameMap::_caller_save_cpu_regs[] = {};
+LIR_Opr FrameMap::_caller_save_fpu_regs[] = {};

Larger changes in sharedRuntime_sparc.cpp, related to removal of
is_critical_native - which is always false, so you can chase that
through the code. In addition,  generate_native_wrapper() loses the
final critical_entry argument, and the functions move_ptr() and
unpack_array_argument() are no longer needed so can be removed.
