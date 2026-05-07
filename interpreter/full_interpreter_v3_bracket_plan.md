# Implementation Plan: Bracket Logic for v3 Interpreter

The final frontier of the Self-Referential Loop is Recursive Control Flow. We must implement '[' (ASCII 91) and ']' (ASCII 93).

## 1. The Forward Jump ([)
**Trigger**: Opcode == 91 AND GuestTape[VDP] == 0.
**Action**:
1. Enter a scan loop starting from IP + 1.
2. Maintain a nesting counter (Start at 1).
3. For each cell encountered:
    - If '[', increment counter.
    - If ']', decrement counter.
4. When counter reaches 0, set IP to current position.
5. Return to Dispatch Hub.

## 2. The Backward Jump (])
**Trigger**: Opcode == 93 AND GuestTape[VDP] != 0.
**Action**:
1. Enter a scan loop starting from IP - 1.
2. Maintain a nesting counter (Start at 1).
3. For each cell encountered:
    - If ']', increment counter.
    - If '[', decrement counter.
4. When counter reaches 0, set IP to current position.
5. Return to Dispatch Hub.

## 3. Technical Integration into v3
- **Range Filter Update**: Add a new cluster for Brackets (Base ASCII = 91).
- **Symmetric Transport**: Use the existing Fetch Mirror mechanism to read tokens during the scan.
- **IP Manipulation**: Directly modify the Instruction Pointer [1] based on the scan result.
- **State Preservation**: Ensure VDP and other Control Hub values remain intact during the search process.
