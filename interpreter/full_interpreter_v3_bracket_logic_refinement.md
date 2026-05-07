# Bracket Logic Refinement for v3 Interpreter

## 1. Memory Extension
To implement nesting depth tracking, we must extend the Control Hub. 
Existing Map:
[0] Hub
[1] IP
[2] VDP
[3] Opcode
[4] Temp A / Match Flag
[5] Outward Mirror
[6] Inward Mirror

Proposed Addition:
[8] Nesting Depth Counter (NDC)
(Shift Guest Tape base to [9] or utilize cells beyond the current range).

## 2. Forward Jump (`[`)
When `Opcode == 91`:
1. **Check Virtual Cell**: Move to `GuestTape[VDP]`. If non-zero, continue normally.
2. **Initialize Scan**: If zero, set NDC = 0.
3. **Linear Search**: 
    - Increment IP.
    - Fetch token at `GuestTape[IP]`.
    - If token == `[`: increment NDC.
    - If token == `]`: decrement NDC.
    - Repeat until NDC == -1.
4. **Finalize**: Set IP to the position of the matching `]` and proceed.

## 3. Backward Jump (`]`)
When `Opcode == 93`:
1. **Check Virtual Cell**: Move to `GuestTape[VDP]`. If zero, continue normally.
2. **Initialize Scan**: If non-zero, set NDC = 0.
3. **Reverse Search**: 
    - Decrement IP.
    - Fetch token at `GuestTape[IP]`.
    - If token == `]`: increment NDC.
    - If token == `[`: decrement NDC.
    - Repeat until NDC == -1.
4. **Finalize**: Set IP to the position of the matching `[` and proceed.

## 4. Technical Implementation in BF
- The search loops must be strictly symmetric. Every fetch during the scan must return the pointer to the Hub before the next IP shift.
- We will use a specialized "Scan Mirror" to handle the relative movement from Hub -> SourceCode[IP] -> Hub.
