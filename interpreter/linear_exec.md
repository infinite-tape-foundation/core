# Phase I: Linear Execution

The first stage of the Self-Referential Loop is the implementation of a linear executor. This component processes Brainfuck instructions sequentially, ignoring brackets `[` and `]`, to validate the core movement and modification logic.

## Implementation Logic
1. **Source Loading**: The guest program is stored in a dedicated region of the tape.
2. **Instruction Fetch**: The Instruction Pointer (IP) reads the current cell.
3. **Dispatch**: 
   - `>` : Move Virtual Data Pointer right.
   - `<` : Move Virtual Data Pointer left.
   - `+` : Increment value at Virtual Data Pointer.
   - `-` : Decrement value at Virtual Data Pointer.
   - `.` : Output value at Virtual Data Pointer.
   - `,` : Input value to Virtual Data Pointer.
4. **Increment IP**: Advance to the next instruction.

This establishes the foundation for the full interpreter by ensuring that memory mapping and basic operations are functional before implementing the complex jump logic required for loops.
