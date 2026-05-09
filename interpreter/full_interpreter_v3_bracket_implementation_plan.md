# Implementation Plan: v3 Bracket Logic Integration

This document details the step-by-step insertion of recursive control flow into `full_interpreter_v3.bf`.

## 1. The Target Location
The bracket logic must be inserted after the Movement Cluster (ASCII 60, 62) and before the final Instruction Pointer (IP) increment at the end of the main loop.

## 2. Range Filtering for Brackets
Brackets reside in the range ASCII 91 (`[`) to 93 (`]`).
- **Base**: 91
- **Offset 0**: `[` 
- **Offset 2**: `]`

Matching sequence:
1. Copy Opcode [3] $\rightarrow$ Temp [4].
2. Subtract 91 from Temp [4].
3. If result == 0 $\rightarrow$ Handle Forward Jump.
4. If result == 2 $\rightarrow$ Handle Backward Jump.

## 3. Forward Jump (`[`) Logic Flow
**Condition**: `Opcode == '['` AND `GuestTape[VDP] == 0`.

**Execution steps**:
1. Set Nesting Counter Cell [4] = 1.
2. Enter Loop:
    a. Increment IP [1].
    b. Fetch Token from `GuestTape[7 + IP]` into a temporary register.
    c. If Token == `[`: Increment Nesting Counter [4].
    d. If Token == `]`: Decrement Nesting Counter [4].
    e. Exit loop if Nesting Counter [4] == 0.
3. Final state: IP is at the matching `]`.

## 4. Backward Jump (`]`) Logic Flow
**Condition**: `Opcode == ']'` AND `GuestTape[VDP] != 0`.

**Execution steps**:
1. Set Nesting Counter Cell [4] = 1.
2. Enter Loop:
    a. Decrement IP [1].
    b. Fetch Token from `GuestTape[7 + IP]` into a temporary register.
    c. If Token == `]`: Increment Nesting Counter [4].
    d. If Token == `[`: Decrement Nesting Counter [4].
    e. Exit loop if Nesting Counter [4] == 0.
3. Final state: IP is at the matching `[`.

## 5. Verification and Integration
- Ensure the VDP check correctly reads from the guest tape using the symmetric transport mechanism established for Arithmetic operations.
- Verify that the IP updates are persistent across the jump.
- Once implemented, this completes the v3 Interpreter's functionality, achieving full self-referential convergence with optimized dispatch.
