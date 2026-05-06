# Implementation Specification: Bracket Logic (Revised)

Building upon the Linear Executor, we now define the precise movements for implementing `[` and `]` within the BF-in-BF interpreter.

## 1. Memory Allocation Update
The current memory map is:
[0] Instruction Pointer (IP)
[1] Current Opcode Register
[2] Virtual Data Pointer (VDP)
[3] Temp / Scratchpad A
[4] Temp / Scratchpad B
[5...] Guest Program and Workspace (SourceBase = 5)

To implement brackets, we require a **Nesting Counter**. To avoid shifting the SourceBase (which would break existing linear logic), we shall utilize cell [3] or [4] as the Nesting Counter *during* the search operation, as these are temporary scratchpads and not used between instructions.

**Finalized Memory Map:**
[0] IP
[1] Opcode
[2] VDP
[3] Temp A / Nesting Counter
[4] Temp B / Search State
[5...] Guest Program (SourceBase = 5)

## 2. Forward Jump (`[` where [GuestTape[VDP]] == 0)
1. **Condition Check**: Fetch value at `SourceBase + VDP`. If $
eq 0$, continue to next instruction (increment IP).
2. **Initialize Search**: Set `Nesting Counter` [3] to 1.
3. **Advance IP**: Increment IP [0].
4. **Search Loop**:
   - Fetch opcode at `SourceBase + IP` into Opcode Register [1].
   - If opcode == `[`: Increment `Nesting Counter` [3].
   - If opcode == `]`: Decrement `Nesting Counter` [3].
   - If `Nesting Counter` [3] == 0: Stop search. The current IP [0] is the matching bracket.
   - Else: Increment IP [0] and repeat loop.

## 3. Backward Jump (`]` where [GuestTape[VDP]] != 0)
1. **Condition Check**: Fetch value at `SourceBase + VDP`. If $0$, continue to next instruction (increment IP).
2. **Initialize Search**: Set `Nesting Counter` [3] to 1.
3. **Retreat IP**: Decrement IP [0].
4. **Search Loop**:
   - Fetch opcode at `SourceBase + IP` into Opcode Register [1].
   - If opcode == `]`: Increment `Nesting Counter` [3].
   - If opcode == `[`: Decrement `Nesting Counter` [3].
   - If `Nesting Counter` [3] == 0: Stop search. The current IP [0] is the matching bracket.
   - Else: Decrement IP [0] and repeat loop.

## 4. Integration Strategy
These will be added as new handlers in the dispatcher of `linear_exec.bf`. 
- For `[`: ASCII 91
- For `]`: ASCII 93
