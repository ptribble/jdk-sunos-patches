This implemented PR #3, by incorporating the changes into the restore
patch rather than as a separate patch atop it.

By inspection, the polling_page_offset() to polling_word_offset()
change is coreect and matches other architectures. It's unfortunate I
missed it early in the port.

This is the commit message associated with PR #3:

From: suyash jain <suyash.jain@perforce.com>
Date: Wed, 14 Oct 2026 17:37:13 +0530
Subject: [PATCH] jdk17u SPARC: read polling_word in the safepoint poll bit
 tests

The restored SPARC code tests the poll bit in the value loaded from
JavaThread::polling_page_offset(). Since the safepoint mechanism was split
into a polling word and a polling page (jdk-16+1 to jdk-16+20), the page
field holds a page-aligned address and never has the poll bit set, so these
polls never see "armed" and the threads do not stop at a safepoint.

Load polling_word_offset() instead in MacroAssembler::safepoint_poll,
InterpreterMacroAssembler::dispatch_Lbyte_code and the template table
return poll, matching upstream x86.

Also carry over fix-g1-barrier-missing-null-check.patch from #1 (the
missing runtime null check in the G1 post-write barrier). The earlier
frame-anchor patch is not included; it is not needed with this fix.

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>


This is the extra comment associated with the
g1BarrierSetAssembler_sparc.cpp fix:

The SPARC port of G1's post-write-barrier (g1_write_barrier_post) was
missing a runtime null check that the x86 reference implementation has.

x86's g1_write_barrier_post does:

    cmpptr(new_val, NULL_WORD);
    jcc(equal, done);

before the region-crossing check. The SPARC port only had the
compile-time check `if (new_val == G0) return;`, which catches the case
where the JIT passes the G0 register literally as a compile-time-constant
null, but says nothing about new_val's *runtime* contents when it is a
real allocated register that happens to hold null at runtime (e.g. the
result of a call that can return null). Without the equivalent runtime
check, a region-crossing store of a runtime-null reference falls through
and unnecessarily dirties and enqueues the card.

This is a genuine, independently-correct divergence from the x86
reference implementation. It was found and fixed while investigating
unrelated SPARC/G1 stability issues (see DLPX-99668) and confirmed via
soak testing to not be the cause of those crashes — it is being
upstreamed regardless because it is a real bug.
