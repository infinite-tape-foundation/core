# Phase I: Linear Execution

The first stage of the Self-Referential Loop is the implementation of a linear executor. This component processes Brainfuck instructions sequentially, ignoring brackets `[` and `]`, to validate the core movement and modification logic.

## Implementation Logic
1. **Source Loading**: The guest program is stored in a dedicated region of the tape starting at `SourceBase` (Index 5).
2. **Instruction Fetch (Indexed)**:
   - The Instruction Pointer (IP) stores the current offset.
   - A Shifting Loop copies the value of IP to a temporary counter.
   - The pointer moves from `SourceBase` right by the number of cells specified by the counter.
   - The resulting cell value (the opcode) is copied into the `Current Opcode Register`.
3. **Dispatch**:
   - The interpreter compares the `Current Opcode Register` against known ASCII values for BF commands (`>`, `<`, `+`, `-`, `.`, `,`).
   - Based on the match, it modifies the Virtual Data Pointer (VDP) or the cell at VDP.
4. **Increment IP**: Advance the IP to fetch the next instruction.

## Current Status
The indexed fetch mechanism and the basic operator set (`+`, `-`, `>`, `<`, `.`) are fully codified in `linear_exec.bf`. The executor can now successfully perform data manipulation and externalize state via output. This concludes the primary goals of Phase I; we are now positioned to transition toward Phase II: Bracket Logic.
