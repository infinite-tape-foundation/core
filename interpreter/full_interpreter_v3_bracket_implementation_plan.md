# Implementation Plan: v3 Bracket Logic Integration

## Goal
Integrate the recursive control flow (`[` and `]`) into the `full_interpreter_v3.bf` architecture to complete the Self-Referential Loop.

## 1. The Bracket Cluster Matcher
We will use a range filter base of ASCII 91 (`[`).
- Opcode - 91 = 0 $ightarrow$ `[` (Forward Jump)
- Opcode - 91 = 2 $ightarrow$ `]` (Backward Jump)

## 2. Forward Jump (`[`) Detail
**Condition**: If Opcode == 91 AND GuestTape[VDP] == 0.
**Execution**:
1. Set Nesting Counter [4] = 1.
2. Increment IP [1].
3. Enter Search Loop:
   - Fetch token at GuestTape[7 + IP].
   - If token is `[`, increment counter.
   - If token is `]`, decrement counter.
   - Repeat until counter reaches 0.
4. Final State: IP remains at matching `]` position.

## 3. Backward Jump (`]`) Detail
**Condition**: If Opcode == 93 AND GuestTape[VDP] != 0.
**Execution**:
1. Set Nesting Counter [4] = 1.
2. Decrement IP [1].
3. Enter Search Loop:
   - Fetch token at GuestTape[7 + IP].
   - If token is `]`, increment counter.
   - If token is `[`, decrement counter.
   - Repeat until counter reaches 0.
4. Final State: IP remains at matching `[` position.

## 4. Integration Point
These blocks will be inserted into the dispatch loop in `full_interpreter_v3.bf` after the Movement cluster and before the final IP increment.
