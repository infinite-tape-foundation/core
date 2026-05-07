# Technical Specification: Bracket Logic for v3 Interpreter

To close the Self-Referential Loop, we must implement recursive control flow using `[` (ASCII 91) and `]` (ASCII 93). The v3 architecture utilizes a Control Hub and a Guest Tape; bracket logic requires modifying the Instruction Pointer (IP [1]) based on searches conducted across the Guest Tape.

## I. Memory Map Integration
During a bracket scan, we utilize the existing mirror system:
- **IP [1]**: Updated to the destination of the jump.
- **Nesting Counter [4]**: Re-purposed from Temp A to track nested brackets during search.
- **Scan Token [3]**: Used to store the current character being inspected during the search loop.

## II. Forward Jump (`[`) - ASCII 91
**Trigger**: Opcode is 91 AND GuestTape[VDP] is 0.

**Algorithm**:
1. **Initialize Search**: Set Nesting Counter = 1.
2. **Increment IP**: Move IP forward by 1.
3. **Fetch Token**: Use symmetric transport to move GuestTape[7 + IP] into Scan Token [3].
4. **Evaluate Token**:
   - If Token == 91 (`[`), increment Nesting Counter.
   - If Token == 93 (`]`), decrement Nesting Counter.
5. **Check Termination**: If Nesting Counter > 0, repeat from step 2.
6. **Finalize**: The current IP now points to the matching `]`. Return to Dispatch Hub.

## III. Backward Jump (`]`) - ASCII 93
**Trigger**: Opcode is 93 AND GuestTape[VDP] is non-zero.

**Algorithm**:
1. **Initialize Search**: Set Nesting Counter = 1.
2. **Decrement IP**: Move IP backward by 1.
3. **Fetch Token**: Use symmetric transport to move GuestTape[7 + IP] into Scan Token [3].
4. **Evaluate Token**:
   - If Token == 93 (`]`), increment Nesting Counter.
   - If Token == 91 (`[`), decrement Nesting Counter.
5. **Check Termination**: If Nesting Counter > 0, repeat from step 2.
6. **Finalize**: The current IP now points to the matching `[`. Return to Dispatch Hub.

## IV. Range Filter Integration
The Bracket Cluster starts at Base 91 (`[`).
- Match `[`: (Opcode - 91) == 0
- Match `]`: (Opcode - 91) == 2
