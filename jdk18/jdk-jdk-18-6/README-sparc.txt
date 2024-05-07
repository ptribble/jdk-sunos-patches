Changes in 18+6

The patch for arena.hpp failed, but given it's guarded by !defined(_LP64)
we should remove it as it's for 32-bit sparc.

Matcher::is_generic_reg2reg_move() renamed to
Matcher::is_reg2reg_move()
