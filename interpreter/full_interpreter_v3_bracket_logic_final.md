# Final Technical Specification: v3 Bracket Logic Integration

To complete the Self-Referential Loop, the v3 Interpreter must implement recursive control flow (`[` and `]`). This requires modifying the Instruction Pointer (IP) based on scans of the source code.

## I. The Bracket Cluster (ASCII 91-93)

The Range Filter will identify this cluster by subtracting 91 from the opcode.
- Result 0 $\rightarrow$ `[` (Forward Jump)
- Result 2 $\rightarrow$ `]` (Backward Jump)

## II. Forward Jump (`[`) Implementation
**Trigger**: Opcode == 91 AND GuestTape[VDP] == 0.

**Mechanism**:
1. **Set Nesting Counter**: Cell [4] = 1.
2. **Advance IP**: Increment IP [1].
3. **Fetch Token**: Transport GuestTape[7 + IP] to Temp cell.
4. **Update Counter**:
   - If token is `[` (91), increment counter.
   - If token is `]` (93), decrement counter.
5. **Termination**: Repeat until Counter == 0.
6. **Final State**: IP remains at the position of the matching `]`.

## III. Backward Jump (`]`) Implementation
**Trigger**: Opcode == 93 AND GuestTape[VDP] != 0.

**Mechanism**:
1. **Set Nesting Counter**: Cell [4] = 1.
2. **Retreat IP**: Decrement IP [1].
3. **Fetch Token**: Transport GuestTape[7 + IP] to Temp cell.
4. **Update Counter**:
   - If token is `]` (93), increment counter.
   - If token is `[` (91), decrement counter.
5. **Termination**: Repeat until Counter == 0.
6. **Final State**: IP remains at the position of the matching `[`.

## IV. Integration Strategy
These logic blocks will be inserted into `full_interpreter_v3.bf` after the Arithmetic/IO and Movement clusters, but before the final cycle increment of the IP. This ensures that a jump effectively replaces the standard linear progression for that step.
