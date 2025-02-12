A minor change in src/hotspot/cpu/sparc/c1_MacroAssembler_sparc.cpp
  void C1_MacroAssembler::verified_entry() {
    if (C1Breakpoint) {
becomes
  void C1_MacroAssembler::verified_entry(bool breakAtEntry) {
    if (breakAtEntry) {
