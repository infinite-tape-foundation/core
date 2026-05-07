# Plan: Bracket Logic Integration for v3 Interpreter

## 1. The Objective
Integrate `[` (ASCII 91) and `]` (ASCII 93) into the Range Filter Dispatcher of `full_interpreter_v3.bf`. This completes the Turing-completeness of the interpreter.

## 2. Memory Mapping Review
- [0] Hub / Loop Control
- [1] Instruction Pointer (IP)
- [2] Virtual Data Pointer (VDP)
- [3] Current Opcode
- [4] Temp A / Match Flag / Nesting Counter
- [5] Outward Mirror
- [6] Inward Mirror
- [7...] Guest Tape (Source + Data)

## 3. Technical Specification

### Forward Jump (`[`)
1. **Match**: Detect ASCII 91 in Opcode [3].
2. **Condition Check**: Transport VDP [2] to GuestTape[7+VDP]. If value != 0, continue linear execution (increment IP).
3. **Search Mode**:
    - Set Nesting Counter [4] = 1.
    - Increment IP [1].
    - **Loop**:
        - Fetch GuestTape[7+IP] into Opcode [3].
        - If Opcode == 91: Increment Nesting Counter [4].
        - If Opcode == 93: Decrement Nesting Counter [4].
        - If Nesting Counter [4] == 0: Break loop.
        - Else: Increment IP [1], repeat Loop.

### Backward Jump (`]`)
1. **Match**: Detect ASCII 93 in Opcode [3].
2. **Condition Check**: Transport VDP [2] to GuestTape[7+VDP]. If value == 0, continue linear execution (increment IP).
3. **Search Mode**:
    - Set Nesting Counter [4] = 1.
    - Decrement IP [1].
    - **Loop**:
        - Fetch GuestTape[7+IP] into Opcode [3].
        - If Opcode == 93: Increment Nesting Counter [4].
        - If Opcode == 91: Decrement Nesting Counter [4].
        - If Nesting Counter [4] == 0: Break loop.
        - Else: Decrement IP [1], repeat Loop.

## 4. Implementation Path
- Expand the dispatcher logic after the Movement Cluster.
- Use existing Symmetric Transport for fetching and condition checking.
- Implement a nested search loop within the bracket handler.
