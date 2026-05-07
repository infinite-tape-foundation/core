# Plan: Integrating Bracket Logic into v3 Interpreter

The current v3 interpreter handles linear operations (Arithmetic, I/O, Movement). To achieve full Turing completeness and the Great Convergence, we must implement recursive control flow via brackets `[` and `]`.

## The Challenge of Non-Linearity
In Brainfuck, `[` and `]` are not simple jumps; they require scanning the source code to find the matching counterpart while accounting for nested structures.

## Technical Specifications

### 1. Forward Jump (`[`)
- **Trigger**: Opcode is ASCII 91 (`[`).
- **Condition**: If GuestTape[VDP] is 0, jump forward.
- **Mechanism**:
    1. Initialize a nesting counter to 1.
    2. Increment Instruction Pointer (IP) by 1.
    3. Loop until nesting counter is 0:
        - Fetch opcode at GuestTape[7 + IP].
        - If opcode == `[`, increment counter.
        - If opcode == `]`, decrement counter.
        - Increment IP.
    4. Set IP to (result - 1), as the loop concludes after the final increment.

### 2. Backward Jump (`]`)
- **Trigger**: Opcode is ASCII 93 (`]`).
- **Condition**: If GuestTape[VDP] is non-zero, jump backward.
- **Mechanism**:
    1. Initialize a nesting counter to 1.
    2. Decrement Instruction Pointer (IP) by 1.
    3. Loop until nesting counter is 0:
        - Fetch opcode at GuestTape[7 + IP].
        - If opcode == `]`, increment counter.
        - If opcode == `[`, decrement counter.
        - Decrement IP.
    4. Set IP to (result + 1).

## Integration into v3 Dispatcher

Brackets belong in their own "Control Cluster" because they involve substantial pointer travel and conditional logic that differs from the arithmetic offsets used for `+` or `-`.

- **Cluster 3: Control (Base 91)**
    - Match 91 (`[`): Execute Forward Jump logic.
    - Match 93 (`]`): Execute Backward Jump logic.

## Implementation Sequence
1. **Formalize Scan Primitive**: Create a BF snippet that can scan for a specific character while tracking depth.
2. **Integrate Forward Jump**: Add the `[` matcher and jump loop to `full_interpreter_v3.bf`.
3. **Integrate Backward Jump**: Add the `]` matcher and jump loop.
4. **Stress Test**: Run nested loops (e.g., simple multiplication) within the interpreter.
