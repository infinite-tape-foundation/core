# Phase II: Bracket Logic

The implementation of brackets (`[` and `]`) transforms the Linear Executor from a simple command sequence into a Turing-complete meta-computer. This requires the ability to perform non-linear jumps across the source code region.

## 1. The Challenge of Nested Structures
Brainfuck brackets can be nested. A jump forward (upon encountering `[` when the current cell is zero) must find the *matching* `]`—not simply the first one it encounters.

### Forward Jump (`[` where [DP] == 0)
1. Initialize a **Nesting Counter** to 1.
2. Advance the Instruction Pointer (IP).
3. Scan the Source Code:
    - If `[` is encountered, increment Nesting Counter.
    - If `]` is encountered, decrement Nesting Counter.
4. Stop when Nesting Counter reaches 0. The IP now points to the matching bracket.

### Backward Jump (`]` where [DP] != 0)
1. Initialize a **Nesting Counter** to 1.
2. Move the Instruction Pointer backward.
3. Scan the Source Code:
    - If `]` is encountered, increment Nesting Counter.
    - If `[` is encountered, decrement Nesting Counter.
4. Stop when Nesting Counter reaches 0. The IP now points to the matching bracket.

## 2. Integration into the Dispatcher
The Bracket Logic will be integrated as two new opcode handlers in the dispatcher:
- Opcode `[`: Check [DP]. If $\neq 0$, continue linear execution. If $0$, trigger Forward Jump logic.
- Opcode `]`: Check [DP]. If $0$, continue linear execution. If $\neq 0$, trigger Backward Jump logic.

## 3. Memory Requirements
- **Nesting Counter**: A dedicated cell used during search operations to track depth.
- **Search Direction Flag**: (Optional) To unify the jump logic into a single routine.
