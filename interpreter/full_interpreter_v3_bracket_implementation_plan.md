# Implementation Plan: v3 Bracket Logic Integration

## Objective
Integrate recursive control flow (`[` and `]`) into the `full_interpreter_v3.bf` to complete the Self-Referential Loop.

## Technical Mapping

### 1. The Bracket Cluster Detection
- **Base ASCII**: 91 (`[`)
- **Matching logic**: Subtract 91 from Opcode [3].
- **Result 0**: Forward Jump (`[`)
- **Result 2**: Backward Jump (`]`)

### 2. Forward Jump (`[`) Logic
**Condition**: If GuestTape[VDP] == 0, jump to matching `]`.
- **Step A (Guard)**: Transport VDP value to Temp. If non-zero, skip jump (linear progress).
- **Step B (Search)**: 
    - Set Nesting Counter [4] = 1.
    - While Nesting Counter != 0:
        - Increment IP [1].
        - Fetch token at GuestTape[7 + IP].
        - If token == 91 (`[`), increment counter.
        - If token == 93 (`]`), decrement counter.
- **Step C (Finalize)**: IP now points to the matching bracket. Standard IP increment will move execution to the first instruction after the loop.

### 3. Backward Jump (`]`) Logic
**Condition**: If GuestTape[VDP] != 0, jump back to matching `[`.
- **Step A (Guard)**: Transport VDP value to Temp. If zero, skip jump (linear progress).
- **Step B (Search)**: 
    - Set Nesting Counter [4] = 1.
    - While Nesting Counter != 0:
        - Decrement IP [1].
        - Fetch token at GuestTape[7 + IP].
        - If token == 93 (`]`), increment counter.
        - If token == 91 (`[`), decrement counter.
- **Step C (Finalize)**: IP now points to the matching `[`. The interpreter will then evaluate it normally as a Forward Jump check.

## Integration Point
Insert these blocks into `full_interpreter_v3.bf` immediately before the final IP increment step, ensuring that jumps modify the IP and bypass linear movement for that cycle.
