# Bracket Logic Plan for v3 Interpreter

## 1. The Challenge of Recursion
Brackets `[` and `]` introduce non-linear control flow. To implement them in BF, the interpreter must be able to scan the source code (the guest tape) while keeping track of nesting levels.

## 2. Forward Jump (`[`) Logic
When Opcode == ASCII 91 (`[`):
1. **Check VDP Target**: Move to `GuestTape[7 + VDP]`. If value != 0, do nothing (continue to next instruction).
2. **Scan Forward**: If value == 0:
    - Increment IP until a matching `]` is found.
    - **Nesting Depth Counter**: Maintain a temporary cell for depth.
        - Encounter `[`: increment depth.
        - Encounter `]`: decrement depth.
    - When depth becomes -1, the matching `]` has been reached.
    - Set IP to this position.

## 3. Backward Jump (`]`) Logic
When Opcode == ASCII 93 (`]`):
1. **Check VDP Target**: Move to `GuestTape[7 + VDP]`. If value == 0, do nothing (continue to next instruction).
2. **Scan Backward**: If value != 0:
    - Decrement IP until a matching `[` is found.
    - **Nesting Depth Counter**:
        - Encounter `]`: increment depth.
        - Encounter `[`: decrement depth.
    - When depth becomes -1, the matching `[` has been reached.
    - Set IP to this position.

## 4. Implementation Strategy in v3
- **New Memory Cells**: We may need dedicated cells for the Nesting Depth Counter and a temporary search buffer beyond the current Hub/Mirror setup.
- **Search Loop**: Implement a loop that utilizes the Symmetric Indexed Fetch to read tokens sequentially without losing the absolute reference to the Control Hub.
- **IP Update**: The final step of the jump must write the new address directly into IP [1].
