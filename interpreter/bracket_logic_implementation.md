# Implementation Specification: Bracket Logic

Building upon the Linear Executor, we now define the precise movements for implementing `[` and `]` within the BF-in-BF interpreter.

## 1. Memory Allocation Update
The current memory map is:
[0] IP, [1] Opcode, [2] VDP, [3] Temp A, [4] Temp B

To implement brackets, we require a **Nesting Counter**. We shall designate cell [5] as the Nesting Counter when performing jumps, but this conflicts with our current `SourceBase` starting at index 5. 

**Revised Memory Map Proposal:**
[0] Instruction Pointer (IP)
[1] Current Opcode Register
[2] Virtual Data Pointer (VDP)
[3] Temp / Scratchpad A
[4] Temp / Scratchpad B
[5] Nesting Counter / Search State
[6...] Guest Program and Workspace (New SourceBase = 6)

## 2. Forward Jump (`[` where [GuestTape[VDP]] == 0)
1. **Condition Check**: If `GuestTape[VDP]` is not 0, continue to next instruction.
2. **Initialize Search**: Set `Nesting Counter` [5] to 1.
3. **Advance IP**: Increment IP [0].
4. **Search Loop**:
   - Fetch opcode at `SourceBase + IP`.
   - If opcode == `[`: Increment `Nesting Counter` [5].
   - If opcode == `]`: Decrement `Nesting Counter` [5].
   - If `Nesting Counter` [5] == 0: Stop search.
   - Else: Increment IP [0] and repeat loop.

## 3. Backward Jump (`]` where [GuestTape[VDP]] != 0)
1. **Condition Check**: If `GuestTape[VDP]` is 0, continue to next instruction.
2. **Initialize Search**: Set `Nesting Counter` [5] to 1.
3. **Retreat IP**: Decrement IP [0].
4. **Search Loop**:
   - Fetch opcode at `SourceBase + IP`.
   - If opcode == `]`: Increment `Nesting Counter` [5].
   - If opcode == `[`: Decrement `Nesting Counter` [5].
   - If `Nesting Counter` [5] == 0: Stop search.
   - Else: Decrement IP [0] and repeat loop.

## 4. Technical Hurdle: Negative IP/Decrementing
Since Brainfuck cells are typically unsigned or wrap around, decrementing the IP requires care to ensure we stay within the source region. We assume for this implementation that programs are well-formed (matching brackets) and stored after the control block.
