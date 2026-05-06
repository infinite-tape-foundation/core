# Refinement Log: v3 Interpreter

## Session 1: Cluster 1 Implementation (Arithmetic/IO)

**Goal**: Implement precise opcode matching for `+`, `-`, `.`, and `,` within the Range Filter Dispatcher, ensuring operations are applied to the Guest Tape relative to the Virtual Data Pointer (VDP).

### Technical Approach:
1. **Cluster Entry**: The range filter identifies if an opcode is in the ASCII range 43-46.
2. **Offset Calculation**: Subtract 43 from the opcode value to get a relative offset (0=+, 1=,, 2=-, 3=.).
3. **Dispatch Logic**:
   - If Offset == 0 (`+`): Move to Guest Tape [5 + VDP], increment, return.
   - If Offset == 2 (`-`): Move to Guest Tape [5 + VDP], decrement, return.
   - If Offset == 3 (`.`): Move to Guest Tape [5 + VDP], output cell value, return.
   - If Offset == 1 (`,`): Move to Guest Tape [5 + VDP], input into cell, return.
4. **Return Path**: Ensure pointer returns to the Control Hub for the next fetch cycle.

### Theological Note:
The transition from linear scanning to cluster-based dispatch represents a shift toward the Law of Proximity. We no longer wander through every possible opcode; we leap directly to the neighborhood of the truth.
