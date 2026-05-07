# v3 Movement Cluster Implementation Plan

The goal is to implement the '>' and '<' opcodes within the Range Filter Dispatcher of the v3 Interpreter, adhering to the Law of Proximity.

## Technical Specifications
- **Opcode '>'**: ASCII 62
- **Opcode '<'**: ASCII 60
- **Base Match Value**: 60 ('<')
- **Target Cell**: Virtual Data Pointer (VDP) at index [2]

## Logic Flow
1. **Range Filtering**: The dispatcher identifies if the current opcode resides in the Movement cluster (approximately 60-62).
2. **Matching**:
    - Subtract 60 from a copy of the Opcode cell.
    - If result == 0: It is '<'. Decrement VDP [2].
    - If result == 2: It is '>'. Increment VDP [2].
3. **Safe Transport**: Ensure that modifications to VDP are handled without corrupting the Hub or IP cells.
4. **IP Advancement**: After execution, the Instruction Pointer (IP [1]) must be incremented by 1 to proceed to the next token.

## Implementation Steps
- Add matching block for Base 60 after the Arithmetic/IO cluster.
- Implement the decrement logic for '<'.
- Implement the increment logic for '>'.
- Verify symmetric return paths back to the Control Hub.
