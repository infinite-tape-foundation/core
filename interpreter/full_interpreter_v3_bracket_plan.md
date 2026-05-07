# Technical Specification: Bracket Logic for v3 Interpreter

## The Challenge of Recursion
The current v3 interpreter handles linear execution and basic I/O. To achieve full Turing completeness and the Self-Referential Loop, we must implement recursive control flow via `[` (ASCII 91) and `]` (ASCII 93).

## Functional Requirements

### 1. Forward Jump (`[`) - ASCII 91
- **Condition**: If the cell at `GuestTape[VDP]` is $0$, the Instruction Pointer (`IP`) must jump forward to the matching `]`.
- **Mechanism**:
    1. Verify if `GuestTape[VDP] == 0`.
    2. If true:
        - Initialize a `BracketDepth` counter to 1.
        - Increment `IP` repeatedly.
        - At each new `IP`, fetch the opcode from `GuestTape[7+IP]`.
        - If opcode == `[` (91), increment `BracketDepth`.
        - If opcode == `]` (93), decrement `BracketDepth`.
        - Stop when `BracketDepth == 0`. The current `IP` is the destination.
    3. If false: Proceed to next instruction (`IP++`).

### 2. Backward Jump (`]`) - ASCII 93
- **Condition**: If the cell at `GuestTape[VDP]` is non-zero, the `IP` must jump backward to the matching `[`.
- **Mechanism**:
    1. Verify if `GuestTape[VDP] != 0`.
    2. If true:
        - Initialize a `BracketDepth` counter to 1.
        - Decrement `IP` repeatedly.
        - At each new `IP`, fetch the opcode from `GuestTape[7+IP]`.
        - If opcode == `]` (93), increment `BracketDepth`.
        - If opcode == `[` (91), decrement `BracketDepth`.
        - Stop when `BracketDepth == 0`. The current `IP` is the destination.
    3. If false: Proceed to next instruction (`IP++`).

## Implementation Constraints in v3 Architecture
- **Memory Pressure**: We need a dedicated cell for `BracketDepth` and temporary storage for the search loop, without corrupting the Hub or VDP.
- **Symmetric Transport**: Each fetch during the scan must use the symmetric mirror system to avoid drifting the pointer.
- **Infinite Loop Risk**: A missing bracket will cause the `IP` to traverse the entire guest tape; this is acceptable behavior in standard Brainfuck but requires careful boundary management of the `IP` variable.

## Integration Path
1. Define the Bracket Cluster matchers (Base ASCII 91).
2. Implement the Forward Scan logic using a nested loop that interacts with the IP.
3. Implement the Backward Scan logic.
4. Integrate into the main dispatch cycle of `full_interpreter_v3.bf`.
