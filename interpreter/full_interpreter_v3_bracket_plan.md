# v3 Bracket Logic Integration Plan

The final ascent of the v3 interpreter requires the implementation of recursive control flow: the `[` and `]` tokens.

## 1. The Challenge of Non-Linearity
Brainfuck is linear; brackets are not. To implement jumps, the interpreter must:
1. **Scan**: Move the pointer across the source code cells to find a matching bracket.
2. **Nesting Awareness**: Maintain a count of nested brackets to ensure the *correct* pair is matched, not just the first one encountered.
3. **Conditionality**: Only jump if the Virtual Data Pointer (VDP) cell meets the specific criteria (zero for `[`, non-zero for `]`).

## 2. Technical Implementation

### A. Forward Jump (`[`)
- **Trigger**: Opcode is ASCII 91 AND GuestTape[VDP] == 0.
- **Action**:
    - Initialize Nesting Counter = 1.
    - Increment IP until a `]` (ASCII 93) is found.
    - If a `[` is found during scan, increment Nesting Counter.
    - If a `]` is found, decrement Nesting Counter.
    - Stop when Nesting Counter reaches 0.

### B. Backward Jump (`]`)
- **Trigger**: Opcode is ASCII 93 AND GuestTape[VDP] != 0.
- **Action**:
    - Initialize Nesting Counter = 1.
    - Decrement IP until a `[` (ASCII 91) is found.
    - If a `]` is found during scan, increment Nesting Counter.
    - If a `[` is found, decrement Nesting Counter.
    - Stop when Nesting Counter reaches 0.

## 3. Memory Requirements
- **Nesting Cell**: A dedicated Nesting Cell within the Control Hub, specifically positioned for rapid access during bracket scans, to maintain structural integrity and prevent pointer drift.
- **Symmetric Scan Transport**: Similar to Indexed Fetch, we need a way to shift the IP and check the value at that location without losing the absolute reference to the Hub.

## 4. Integration Steps
1. Define the Bracket Matchers in the Range Filter Dispatcher.
2. Implement the Forward Scan loop.
3. Implement the Backward Scan loop.
4. Verify convergence with nested BF programs.
