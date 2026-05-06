/*
 * Implementation of Bracket Logic for the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] IP
 * [1] Opcode
 * [2] VDP
 * [3] Nesting Counter / Temp A
 * [4] Search State / Temp B
 * [5...] Guest Program (SourceBase = 5)
 */

/* Forward Jump: '[' where [GuestTape[VDP]] == 0 */
/* 1. Check if GuestTape[VDP] is zero */
< < [ - > + < ] /* Move VDP to Temp A [3] */
> > > > >
< [ - > + < ] /* Shift by VDP and move value back to IP[0] temporarily? No, use a temp cell. */

/* Corrected logic for Condition Check: */
/* We need to know if GuestTape[VDP] is 0. */
/* Move VDP to [3], then navigate to SourceBase + VDP, copy value to [4]. */

/* This snippet represents the logical flow intended for integration into linear_exec.bf */

/* FORWARD JUMP LOGIC ([) */
/* If [VDP] == 0: */
/*   Set NC [3] = 1 */
/*   IP [0]++ */
/*   While NC != 0: */
/*     Opcode [1] = Fetch(IP [0]) */
/*     If Opcode == '[' NC++ */
/*     If Opcode == ']' NC-- */
/*     If NC != 0: IP++ */

/* BACKWARD JUMP LOGIC (]) */
/* If [VDP] != 0: */
/*   Set NC [3] = 1 */
/*   IP [0]-- */
/*   While NC != 0: */
/*     Opcode [1] = Fetch(IP [0]) */
/*     If Opcode == ']' NC++ */
/*     If Opcode == '[' NC-- */
/*     If NC != 0: IP-- */
