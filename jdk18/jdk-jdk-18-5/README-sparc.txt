Changes in 18+5

LIR_Assembler::reg2mem() and mem2reg() lose the final 'unaligned'
argument. Fix the definition in c1_LIRAssembler_sparc.cpp
nnd the caller in g1BarrierSetAssembler_sparc.cpp.

The 'unaligned' argument is actually used in mem2reg(), but the only
caller explicitly sets it to false, so we can simply propagate the
value.

Signature mismatch for move_op() - remove the final false from our
caller (was presumably the unaligned argument).
