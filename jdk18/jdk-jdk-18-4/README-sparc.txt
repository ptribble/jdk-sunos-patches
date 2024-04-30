Changes in 18+4

Need to pull sparc-linker.patch from 17.0.2-ga to fix the 'Linker
older than 2.18' error.

Matcher::float_pressure() has been deleted. It's been replaced by
Matcher::int_pressure_limit Matcher::float_pressure_limit. Implemented
these like other platforms, taking INTPRESSURE = 48 FLOATPRESSURE = 52
from definitions in 18+2, and removing the define_pd_global() for
those variables.

UseBiasedLocking was cleaned out. Remove use_biased_locking()
UseBiasedLocking biased_locking_enter() runtime/biasedLocking.hpp
PrintBiasedLockingStatistics biased_locking_exit() try_bias
BiasedLockingCounters.

Build fails in sparc.ad on missing _counters arg for
compiler_lock_object(), we should remove this argument (removed from callers)

Build fails with undefined counters in macroAssembler_sparc.cpp
again we've removed the argument from compiler_lock_object()

Build fails with missing symbol
frame::optimized_entry_frame_is_first() in frame_sparc.cpp
copied the no-op implementation as used in s390 and ppc
