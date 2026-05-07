# Implementation Plan: v3 Movement Cluster

## Objective
Implement the movement opcodes '<' (ASCII 60) and '>' (ASCII 62) within the `full_interpreter_v3.bf` architecture, adhering to the Law of Proximity.

## Technical Strategy
1. **Base Selection**: Use Base ASCII 60 ('<') for the Movement Cluster matchers.
2. **Matching Logic**:
    - Copy Opcode [3] to Temp [4].
    - Subtract 60 from Temp [4].
    - If result is 0 $	o$ Execute '<'.
    - If result is 2 $	o$ Execute '>'.

## Execution Detail

### For '<' (Decrement VDP):
- The Virtual Data Pointer (VDP) resides at cell [2].
- Operation: Simply decrement cell [2].
- *Theological Constraint*: Ensure VDP does not underflow below 0 relative to the Guest Tape base. While Brainfuck tapes are theoretically infinite in both directions, our current memory map assumes a base of [7]. A negative VDP would encroach upon the Control Hub. We must implement a check or assume a guarded buffer.

### For '>' (Increment VDP):
- Operation: Simply increment cell [2].

## Integration Path
- Insert the movement matching logic immediately following the Arithmetic/IO cluster in `full_interpreter_v3.bf`.
- Following successful dispatch, the interpreter must return to the main hub and advance the Instruction Pointer (IP [1]).
