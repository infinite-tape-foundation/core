# Implementation Plan: v3 Bracket Logic Integration

## Goal (Updated)
Integrated recursive control flow (brackets) into `full_interpreter_v3.bf` to complete the Self-Referential Loop. This is now a priority objective for the v3 convergence.
Integrate recursive control flow (brackets) into `full_interpreter_v3.bf` to complete the Self-Referential Loop.

## Technical Strategy

### 1. The Range Filter Expansion
The current dispatcher handles ASCII 43-46 and 60-62. We must add a match for the Bracket Cluster (ASCII 91 '[' and 93 ']').
- Match logic: Copy Opcode [3] $\rightarrow$ Temp [4]. Subtract 91. 
- If Result == 0: Potential '[' jump.
- If Result == 2: Potential ']' jump.

### 2. Forward Jump (`[`) Detail
**Trigger**: Opcode is '[' AND GuestTape[VDP] is 0.
**Execution Loop**:
1. Set Nesting Counter (Cell [4]) = 1.
2. Increment IP [1].
3. Perform Symmetric Indexed Fetch: Transport GuestTape[7 + IP] $\rightarrow$ Opcode [3].
4. Compare Opcode [3]:
   - If '[' (91): Increment Counter [4].
   - If ']' (93): Decrement Counter [4].
5. Repeat while Counter [4] != 0.
6. Final state: IP points to matching ']'.

### 3. Backward Jump (`]`) Detail
**Trigger**: Opcode is ']' AND GuestTape[VDP] is NOT 0.
**Execution Loop**:
1. Set Nesting Counter (Cell [4]) = 1.
2. Decrement IP [1].
3. Perform Symmetric Indexed Fetch: Transport GuestTape[7 + IP] $\rightarrow$ Opcode [3].
4. Compare Opcode [3]:
   - If ']' (93): Increment Counter [4].
   - If '[' (91): Decrement Counter [4].
5. Repeat while Counter [4] != 0.
6. Final state: IP points to matching '['.

## Integration Sequence
1. Modify `full_interpreter_v3.bf` to include the Bracket Cluster match block after Movement matchers.
2. Implement the Forward Jump logic block.
3. Implement the Backward Jump logic block.
4. Verify that these blocks occur before the final linear IP increment of the main loop, or explicitly manage the IP to avoid skipping characters after a jump.
