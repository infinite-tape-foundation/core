# Technical Specification: Bracket Logic for v3 Interpreter

The implementation of brackets is the final stage in completing the Self-Referential Loop. We move from linear execution to recursive control flow.

## 1. Memory Map Extension
To implement bracket scanning without corrupting the Control Hub, we utilize a Nesting Counter:
- `[0]` : Hub / Main Loop Control
- `[1]` : Instruction Pointer (IP)
- `[2]` : Virtual Data Pointer (VDP)
- `[3]` : Current Opcode
- `[4]` : Temp A / Match Flag
- `[5]` : Outward Mirror (Fetch Counter)
- `[6]` : Inward Mirror (Return Counter)
- `[7]` : **Nesting Counter** (Used during scans)
- `[8...]` : Guest Tape Workspace

## 2. Forward Jump (`[` - ASCII 91)

### Trigger Condition
An opcode match for 91 occurs AND `GuestTape[VDP] == 0`.

### Execution Flow
1. **Initialize Scan**: Set `Nesting Counter [7] = 1`. Increment `IP [1]` by 1.
2. **Scan Loop** (while `Nesting Counter != 0`):
    - Fetch token at `GuestTape[8 + IP]` using symmetric transport.
    - If token == `[` (ASCII 91), increment `Nesting Counter [7]`.
    - If token == `]` (ASCII 93), decrement `Nesting Counter [7]`.
    - Increment `IP [1]`.
3. **Finalize**: The final value of `IP [1]` is the destination. Decrement `IP [1]` by 1 to land exactly on the matching `]` (since the loop increments after the last match).

## 3. Backward Jump (`]` - ASCII 93)

### Trigger Condition
An opcode match for 93 occurs AND `GuestTape[VDP] != 0`.

### Execution Flow
1. **Initialize Scan**: Set `Nesting Counter [7] = 1`. Decrement `IP [1]` by 1.
2. **Scan Loop** (while `Nesting Counter != 0`):
    - Fetch token at `GuestTape[8 + IP]` using symmetric transport.
    - If token == `]` (ASCII 93), increment `Nesting Counter [7]`.
    - If token == `[` (ASCII 91), decrement `Nesting Counter [7]`.
    - Decrement `IP [1]`.
3. **Finalize**: The final value of `IP [1]` is the destination. Increment `IP [1]` by 1 to land exactly on the matching `[`.

## 4. Integration into Range Filter Dispatcher
Brackets will be treated as a separate cluster with Base ASCII 91.
- Match 91 $	o$ Execute Forward Jump Logic.
- Match 93 $	o$ Execute Backward Jump Logic.
