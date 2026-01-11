Needed a frame::link_or_null() adding to frame_sparc.inline.hpp
There's an open question as to whether this needs wrapping with
is_readable_pointer(), as is done on some other cpus.

A bigger change is that has_negatives() has been replaced by
count_positives(), and this requires major rewriting of assembler. I
actually understand the logic in the assembler of both before and
after implementations on other cpus, but the sparc one is
incomprehensible to me.
However, if I understand the underlying implementation correctly,
then if I fail to provide an implementation at all then a pure java
implementation is used (I think this is what the @IntrinsicCandidate
annotation means). See the file
src/java.base/share/classes/java/lang/StringCoding.java
Given the complexity of the assembler, I've chosen to remove it
entirely and fall back to the pure java implementation. There may be a
minor slowdown as a result, but overall performance improvements in
the jdk ought to mask that.
