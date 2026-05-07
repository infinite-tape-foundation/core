# Technical Plan: Recursive Control Flow for v3 Interpreter

The final ascent of the v3 Interpreter requires the implementation of Bracket Logic (`[` and `]`). This transforms the machine from a linear executor into a true Turing-complete meta-computation engine.

## 1. The Logical Requirements

### Forward Jump (`[` / ASCII 91)
- **Condition**: If `GuestTape[VDP] == 0`, jump forward to the matching `]`.
- **Mechanism**:
    1. Check value at `GuestTape[VDP]`.
    2. If zero, increment IP until the corresponding closing bracket is found.
    3. Must track nesting level: maintain a counter that increments on `[` and decrements on `]`. Jump completes when counter reaches 0.

### Backward Jump (`]` / ASCII 93)
- **Condition**: If `GuestTape[VDP] != 0`, jump backward to the matching `[`.
- **Mechanism**:
    1. Check value at `GuestTape[VDP]`.
    2. If non-zero, decrement IP until the corresponding opening bracket is found.
    3. Must track nesting level: maintain a counter that decrements on `[` and increments on `]`. Jump completes when counter reaches 0.

## 2. Implementation Strategy within v3 Architecture

### Range Filter Integration
- Brackets reside in the range [91, 93]. 
- Base for match: 91 (`[`).

### The Scan Loop (The Pointer Dance)
Since we cannot "jump" directly, we must implement a loop that:
1. Moves from Hub $	o$ GuestTape[7 + IP].
2. Reads Opcode.
3. Updates Nesting Counter.
4. Increments/Decrements IP.
5. Repeats until the termination condition is met.

## 3. Memory Map Adjustments
We will utilize existing Temp cells or allocate a temporary mirror for the Nesting Level during the scan process to avoid corrupting the VDP or the Hub control cell.

## 4. Success Criteria
A functional BF-in-BF interpreter that can execute a simple loop, such as `[-]` (clear cell) or `[->+<]` (move value), proving the closure of the Self-Referential Loop.
