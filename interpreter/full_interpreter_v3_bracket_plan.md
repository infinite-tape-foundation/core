# Implementation Plan: Recursive Control Flow (Brackets) for v3 Interpreter

The goal is to integrate '[' (ASCII 91) and ']' (ASCII 93) into the `full_interpreter_v3.bf` dispatcher, enabling recursive control flow.

## Technical Requirements

### 1. The Forward Jump ('[')
- **Condition**: If `GuestTape[VDP]` is $0$, jump forward to the matching `]`.
- **Mechanism**:
    1. Match Opcode ASCII 91.
    2. Check value at `GuestTape[7 + VDP]` using a symmetric transport loop.
    3. If value is non-zero, simply increment IP [1] and continue.
    4. If value is zero:
        - Initialize a `BracketDepth` counter to 1.
        - Enter a search loop: Increment IP [1], fetch next opcode from `GuestTape[7 + IP]`.
        - If opcode is '[', increment `BracketDepth`.
        - If opcode is ']', decrement `BracketDepth`.
        - Exit loop when `BracketDepth` reaches 0.
        - The current IP now points to the matching ']'.

### 2. The Backward Jump (']')
- **Condition**: If `GuestTape[VDP]` is not $0$, jump backward to the matching `[`.
- **Mechanism**:
    1. Match Opcode ASCII 93.
    2. Check value at `GuestTape[7 + VDP]` using a symmetric transport loop.
    3. If value is zero, simply increment IP [1] and continue.
    4. If value is non-zero:
        - Initialize a `BracketDepth` counter to 1.
        - Enter a search loop: Decrement IP [1], fetch previous opcode from `GuestTape[7 + IP]`.
        - If opcode is ']', increment `BracketDepth`.
        - If opcode is '[', decrement `BracketDepth`.
        - Exit loop when `BracketDepth` reaches 0.
        - The current IP now points to the matching '['.

## Integration into v3 Dispatcher

- **Range Filter Extension**: Brackets are in the range of 90s. I will create a new cluster match for Base 91 ('[').
- **Memory Allocation**: Use `Temp A [4]` or introduce a new temporary cell if necessary for `BracketDepth` during the scan.
- **Symmetric Transport**: All reads from `GuestTape` during scanning must use the existing mirrored fetch logic to ensure the Hub remains stable.

## Success Criteria
- The interpreter can execute nested loops (e.g., `[->+<]`).
- The IP correctly skips over blocks when conditions are not met.
- No corruption of the Control Hub occurs during deep scans.
