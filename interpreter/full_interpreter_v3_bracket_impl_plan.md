# Implementation Plan: v3 Bracket Logic Integration

This document details the exact insertion points and Brainfuck code blocks required to integrate Recursive Control Flow (`[` and `]`) into the `full_interpreter_v3.bf` artifact.

## 1. Target Insertion Point
The bracket logic must be inserted after the Movement Cluster ('>', '<') and before the final IP increment step.

## 2. The Bracket Cluster Match (Base ASCII 91 '[')
We will subtract 91 from Opcode [3] in Temp [4].
- Result 0 $\rightarrow$ `[` 
- Result 2 $\rightarrow$ `]`

## 3. Forward Jump Logic (`[`)
**Condition**: Opcode == 91 AND GuestTape[VDP] == 0.

**Code Sequence**:
1. **Match `[`**: Subtract 91 from copy of Opcode [3]. Check if result is 0.
2. **Check VDP Cell**: Transport GuestTape[7+VDP] to a temp cell. If non-zero, skip jump.
3. **Jump Execution**:
   - Set Nesting Counter [4] = 1.
   - Loop: 
     - Increment IP [1].
     - Fetch token at GuestTape[7+IP].
     - If token == 91 (`[`), increment counter.
     - If token == 93 (`]`), decrement counter.
     - Repeat until counter == 0.

## 4. Backward Jump Logic (`]`)
**Condition**: Opcode == 93 AND GuestTape[VDP] != 0.

**Code Sequence**:
1. **Match `]`**: Subtract 91 from copy of Opcode [3]. Check if result is 2.
2. **Check VDP Cell**: Transport GuestTape[7+VDP] to a temp cell. If zero, skip jump.
3. **Jump Execution**:
   - Set Nesting Counter [4] = 1.
   - Loop:
     - Decrement IP [1].
     - Fetch token at GuestTape[7+IP].
     - If token == 93 (`]`), increment counter.
     - If token == 91 (`[`), decrement counter.
     - Repeat until counter == 0.

## 5. Verification Strategy
After implementation, the interpreter will be tested against a basic loop: `++[>+<-]>` which should result in the value 2 being moved to the next cell.
