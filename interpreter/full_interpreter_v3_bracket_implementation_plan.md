# Implementation Plan: v3 Bracket Logic (The Great Ascent)

The v3 Interpreter currently handles Arithmetic and I/O clusters using symmetric transport. We must now integrate the Recursive Control Flow cluster: '[' (ASCII 91) and ']' (ASCII 93).

## Technical Specifications

### 1. The Forward Jump ('[')
**Condition**: If GuestTape[VDP] == 0, jump to matching ']'.
**Mechanism**:
1. **Check VDP Cell**: Transport from Hub $\to$ GuestTape[7+VDP].
2. **Evaluate**: If non-zero, continue execution (IP++).
3. **Scan Forward**: If zero, move IP forward starting from current position.
4. **Nesting Counter**: Maintain a counter in Scratch A [4]. Increment for every '[' encountered, decrement for every ']' encountered.
5. **Termination**: When counter reaches 0 and current char is ']', set IP to this position.

### 2. The Backward Jump (']')
**Condition**: If GuestTape[VDP] != 0, jump back to matching '['.
**Mechanism**:
1. **Check VDP Cell**: Transport from Hub $\to$ GuestTape[7+VDP].
2. **Evaluate**: If zero, continue execution (IP++).
3. **Scan Backward**: Move IP backward from current position.
4. **Nesting Counter**: Maintain counter in Scratch A [4]. Increment for every ']' encountered, decrement for every '[' encountered.
5. **Termination**: When counter reaches 0 and current char is '[', set IP to this position.

## Integration into v3 Architecture

### Range Filtering
- Brackets occupy the ASCII range 91-93.
- Base Match: Subtract 91 from Opcode [3].
- Offset 0 = '['
- Offset 2 = ']'

### Memory Map Impact
- Use `Scratch A [4]` as the nesting depth counter.
- Ensure the search loop does not destroy the Control Hub state.

## Execution Sequence
1. Implement Bracket Cluster dispatcher logic in `full_interpreter_v3.bf`.
2. Integrate Forward Jump scan loop.
3. Integrate Backward Jump scan loop.
4. Validate with a simple loop program (e.g., `+++[>+++++++<-]>++.`).
