A couple of change in cpu code were ignored.

Small change in sharedRuntime_foo.cpp
  in montgomery_multiply() and montgomery_square(), but we don't have
  either of those, so nothing to do
is_interpreted_frame_valid() in frame_foo.cpp is much extended on some cpus
  but sparc already had the extended version, so nothing to do here either
