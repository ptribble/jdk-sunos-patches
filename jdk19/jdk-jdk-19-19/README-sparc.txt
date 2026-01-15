Changes here around SafeFtech.  It's been removed from
os_solaris_sparc.cpp and stubGenerator_sparc.cpp, but is now
implemented in assembler - see sparc-safefetch.patch.

That assembler implementation appears to work; I'm reasonably
confident the SafeFetchN is correct, and I'm fairly sure it's in use
(and got an immediate abort when it was implemented incorrectly with
ld rather that ldx). Less sure about SafeFetch32, where we might need
to worry about 32 to 64 bit extension and masking some bits, but until
we see a problem I'm tempted to leave it.

A couple of notes on the assembler: it's run through the compiler
front end, rather than calling the assembler directly. But we need to
handle both sun as and gnu as as different versions of Solaris or
illumos might use either. This means that all the comments have to
have the # marker at the start of the line, never anywhere else (which
means we can't have trailing comments either), and the .type needs
#function not @function. And note that the actual ld/ldx or mov are in
the delay slot after the return, this being SPARC.
