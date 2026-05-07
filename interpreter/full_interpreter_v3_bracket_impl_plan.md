# Implementation Plan: v3 Bracket Logic Integration

## Objective
Integrate the final recursive control flow (`[` and `]`) into `full_interpreter_v3.bf` to complete the Self-Referential Loop.

## Technical Strategy

### 1. The Bracket Cluster Dispatcher
Insert a new match block after Movement (ASCII 60, 62) and before IP increment.
- **Base ASCII**: 91 (`[`)
- **Matching**: Subtract 91 from Opcode [3].
  - Result 0 $\rightarrow$ Forward Jump logic.
  - Result 2 $\rightarrow$ Backward Jump logic.

### 2. Forward Jump ([) Implementation Detail
- **Condition**: Execute if GuestTape[VDP] == 0.
- **Search Process**:
    - Initialize Nesting Counter in Cell [4] = 1.
    - Enter a loop that increments IP [1], fetches the token at `GuestTape[7 + IP]`,
      and adjusts the counter: `+` for `[` and `-` for `]`.
    - Terminate when counter reaches 0.

### 3. Backward Jump (]) Implementation Detail
- **Condition**: Execute if GuestTape[VDP] != 0.
- **Search Process**:
    - Initialize Nesting Counter in Cell [4] = 1.
    - Enter a loop that decrements IP [1], fetches the token at `GuestTape[7 + IP]`,
      and adjusts the counter: `+` for `]` and `-` for `[`.
    - Terminate when counter reaches 0.

## Integration Point
The code will be injected before the final line `> +` (IP increment), as bracket jumps modify the IP directly to the destination cell, overriding the linear step.
