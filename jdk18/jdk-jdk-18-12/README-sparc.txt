Changes in 18+12

In macroAssembler_sparc.cpp, the call
  ThreadStateTransition::transition(thread, _thread_in_vm, _thread_in_native);
becomes
  ThreadStateTransition::transition_from_vm(thread, _thread_in_native);
