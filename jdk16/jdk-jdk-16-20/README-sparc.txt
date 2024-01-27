The whole of SPARC support was removed along with solaris. There is
a separate set of patches added to restore sparc support.

The patches are split out and listed in the separate .pls.sparc patch
list. Some of the patches make changes across the source tree that are
necessary for SPARC, but don't fix up any other os or cpu variants, so
aren't safe to apply on other systems.

Changes in this release:

A lot of these changes mirror solaris_x86 to deal with the stack
handling and signal handling rework done in the jdk.

The hunk defining the ADI signals is now applied to signals_posix.cpp
instead of os_posix.cpp

As part of the stack handling rework, need to add
#include "prims/methodHandles.hpp"
to sharedRuntime_sparc.cpp, and change
JavaThread::stack_shadow_zone_size() -> StackOverflow::stack_shadow_zone_size()
JavaThread::stack_guard_zone_size() -> StackOverflow::stack_guard_zone_size()
JavaThread::stack_guard_yellow_reserved_disabled -> StackOverflow::stack_guard_yellow_reserved_disabled

Cleaned up some fuzz in the main patch associated with tha renaming to
reduce the noise.

In templateTable_sparc.cpp, remove the now unused
TemplateTable::pd_initialize()

As part of the signal handling rework, #include "signals_posix.hpp"

Remove get_frame_at_stack_banging_point()

Add os::fetch_compiled_frame_from_context()
the equivalent code for the first argument on sparc didn't have the +1
that we have on x86, so don't add +1 here either
looking at the code for get_frame_at_stack_banging_point(), we get sp
the same way as x86, but sparc doersn't get fp, and where we would
have used fp we put frame::unpatchable so in this function instead of
fr.fp() use frame::unpatchable (and see also the sparc
fetch_frame_from_context() implementation that does the same thing)
and instead of using the sp for the last argument we use what was
saved in REG 07

Method renaming
os::Solaris::chained_handler() -> PosixSignals::chained_handler()
os::Solaris::signal_handlers_are_installed -> PosixSignals::are_signal_handlers_installed()

Remove OSThread::SR_handler(t, uc); within ASYNC_SIGNAL

Applied the redzone handling fixes that were done on x86 much later,
so we don't get the errors.

Clean up libjsig_is_loaded

For the error:
src/hotspot/cpu/sparc/macroAssembler_sparc.hpp:221:3: note:   no known conversion for argument 2 from 'ByteSize' to 'Register {aka RegisterImpl*}'
./src/hotspot/cpu/sparc/macroAssembler_sparc.hpp:216:3: note: candidate: Address::Address(Register, RegisterOrConstant)
In the s390 source (and others) there's an Address(Register base,
ByteSize disp) that's guarded by an ASSERT. Apply the same fix as
s390, and do that in a number of other places.

The following changes in s390:
1. in src/hotspot/cpu/s390/c1_CodeStubs_s390.cp
+void C1SafepointPollStub::emit_code(LIR_Assembler* ce) {
+  ShouldNotReachHere();
+}
+
2. In src/hotspot/cpu/s390/c1_LIRAssembler_s390.cpp
-void LIR_Assembler::return_op(LIR_Opr result) {
+void LIR_Assembler::return_op(LIR_Opr result, C1SafepointPollStub* code_stub) {
Also need applying to SPARC.

The type of narrowOop has changed from a juint to an enum of uint32_t,
which triggers the odd 'no matching function' error due to it changing
method signatures.
Eventually narrowed down to
src/hotspot/cpu/sparc/macroAssembler_sparc.cpp, and the simplest and
correct fix is to change the type of encoded_k from narrowOop to
uint32_t

Move interpreter_frame_initial_sp_offset from frame_sparc.cpp to the
enum containing interpreter_frame_vm_local_words in frame_sparc.hpp,
otherwise you get
error: 'interpreter_frame_initial_sp_offset' is not a member of 'frame'

In relocInfo_sparc.cpp
CompressedOops::encode((oop)x)
should be
CompressedOops::narrow_oop_value((oop)x)

Removed the count_calls() function from templateTable_sparc.cpp, it
has no callers and generates an error as it's not declared.

There were call_VM() calls to InterpreterRuntime::monitorexit that
were causing a SIGSEGV. The signature of monitorexit had been changed
to remove an initial Thread argument. The problem here is that
call_VM() dynamically generates the call, and automatically adds a
Thread argument for you. Using call_VM_leaf() doesn't do so, so change
to using that instead.
