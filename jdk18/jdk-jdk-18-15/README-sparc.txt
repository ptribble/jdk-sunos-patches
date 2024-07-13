Changes in 18+15

Remove
  void frame::pd_ps() {}
from frame_XXX.cpp

Other architectures are a no-op, sparc isn't, but there are no callers
any more, and the only one was debugging. And it wasn't used in
PRODUCT builds anyway.
