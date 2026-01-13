Some changes needed to handle addition of RISCV.

Significant changes to c1_LIR. One thing is that cond was inlined in
some calls. Another was a change from LIR_Op() to LIR_Op2(), with
extra arguments.
