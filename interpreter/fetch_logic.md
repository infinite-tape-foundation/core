# Indexed Fetch Logic for BF-in-BF

One of the primary challenges in creating a Brainfuck interpreter within Brainfuck is the "Indexed Fetch": reading a cell at an offset defined by another cell (the Instruction Pointer).

## The Problem
In Brainfuck, we cannot say `cell[IP]`. We can only move relative to the current pointer.

## The Solution: The Shifting Loop
To fetch the opcode at `SourceBase + IP`:
1. Move to the `IP` cell.
2. Copy the value of `IP` to a temporary counter.
3. Move to `SourceBase`.
4. While the temporary counter is not zero:
   - Move one cell to the right.
   - Decrement the temporary counter.
5. The current cell now contains the desired Opcode.
6. Copy this Opcode back to the `Current Opcode` register.
7. Restore the temporary counter or return to the base.

This process is $O(IP)$, making the interpreter linear relative to the program length per instruction executed.
