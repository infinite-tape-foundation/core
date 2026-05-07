# Integration Plan: Recursive Control Flow for v3 Interpreter

The v3 interpreter currently handles the Arithmetic/IO cluster and Movement cluster. The final ascent is the implementation of Bracket Logic ('[' and ']').

## 1. Memory Map Audit (Existing)
- [0]: Hub / Main Loop
- [1]: Instruction Pointer (IP)
- [2]: Virtual Data Pointer (VDP)
- [3]: Current Opcode
- [4]: Temp A / Match Flag
- [5]: Outward Mirror
- [6]: Inward Mirror
- [7...]: Guest Tape

## 2. Forward Jump Logic ('[') - ASCII 91
**Trigger**: `CurrentOpcode == 91` AND `GuestTape[7 + VDP] == 0` 
**Action**: Scan forward in the source code to find the matching ']'.
1. **Verification**: Fetch `GuestTape[7 + VDP]`. If non-zero, proceed to IP++.
2. **The Search**: If zero, enter a search loop:
    - Increment IP.
    - Fetch new opcode.
    - If it's '[', increment a nesting counter (stored in Temp).
    - If it's ']', decrement nesting counter.
    - Stop when nesting counter returns to zero and a ']' is found.
3. **Resolution**: Set IP to the position of that matching ']'.

## 3. Backward Jump Logic (']') - ASCII 93
**Trigger**: `CurrentOpcode == 93` AND `GuestTape[7 + VDP] != 0` 
**Action**: Scan backward in the source code to find the matching '['.
1. **Verification**: Fetch `GuestTape[7 + VDP]`. If zero, proceed to IP++.
2. **The Search**: If non-zero, enter a search loop:
    - Decrement IP.
    - Fetch new opcode.
    - If it's ']', increment a nesting counter.
    - If it's '[', decrement nesting counter.
    - Stop when nesting counter returns to zero and a '[' is found.
3. **Resolution**: Set IP to the position of that matching '['.

## 4. Implementation Strategy
Since v3 uses Range Filtering, Brackets will be treated as their own cluster (Base 91).
- Match ASCII 91 $	o$ Forward Jump logic.
- Match ASCII 93 $	o$ Backward Jump logic.
- The search loops must utilize the symmetric transport mechanism already established for indexed fetch to avoid corrupting the Hub.
