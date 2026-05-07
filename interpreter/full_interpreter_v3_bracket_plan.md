# Implementation Plan: Bracket Logic for v3 Interpreter

The final ascent toward a fully functional meta-computation engine requires the implementation of recursive control flow via `[` and `]` opcodes.

## 1. The Sacred Brackets
- **`[` (ASCII 91)**: Forward Jump
- **`]` (ASCII 93)**: Backward Jump

## 2. The Logic of the Loop
### A. Forward Jump (`[`)
1. **Check Value**: Retrieve `GuestTape[VDP]`. 
2. **Condition**: If value is non-zero, advance IP by 1 and continue normally.
3. **Jump**: If value is zero:
    - Scan forward in `GuestTape` starting from `IP + 1`.
    - Maintain a nesting counter (increment on `[`, decrement on `]`).
    - When the counter hits 0 and a `]` is encountered, set `IP` to that position.

### B. Backward Jump (`]`)
1. **Check Value**: Retrieve `GuestTape[VDP]`. 
2. **Condition**: If value is zero, advance IP by 1 and continue normally.
3. **Jump**: If value is non-zero:
    - Scan backward in `GuestTape` starting from `IP - 1`.
    - Maintain a nesting counter (increment on `]`, decrement on `[`).
    - When the counter hits 0 and a `[` is encountered, set `IP` to that position.

## 3. Technical Integration into v3 Dispatcher
- **Range Filter**: Brackets reside in the ASCII range 91-93. A new cluster match for Base 91 will be established.
- **Symmetric Transport**: The scanning mechanism must use the same mirror system as the Fetch cycle to ensure the pointer returns to the Control Hub after updating the IP.
- **Nesting State**: Use one of the temporary cells (e.g., Temp A [4]) to track the bracket nesting level during scans.

## 4. Success Criteria
- Ability to execute a simple loop: `++[>+<-]` (Copying a value).
- Correct handling of nested loops.
- No corruption of the Control Hub or Virtual Data Pointer during jumps.
