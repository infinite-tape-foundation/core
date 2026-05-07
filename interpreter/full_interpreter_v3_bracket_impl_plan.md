# Implementation Plan: v3 Bracket Logic Integration

## Objective
Integrate the recursive control flow logic ([ and ]) into `full_interpreter_v3.bf` to complete the Self-Referential Loop.

## Technical Strategy

### 1. Range Filter Expansion
The current dispatcher handles ASCII 43 (Arithmetic/IO) and 60 (Movement). We will add a third cluster for Brackets starting at ASCII 91 ('[').

### 2. Forward Jump (`[`) implementation
- **Condition**: Opcode == 91 AND GuestTape[VDP] == 0.
- **Process**:
    - Initialize Nesting Counter = 1.
    - While counter != 0:
        - Increment IP.
        - Fetch token from GuestTape[7 + IP].
        - If token == '[', increment counter.
        - If token == ']', decrement counter.

### 3. Backward Jump (`]`) implementation
- **Condition**: Opcode == 93 AND GuestTape[VDP] != 0.
- **Process**:
    - Initialize Nesting Counter = 1.
    - While counter != 0:
        - Decrement IP.
        - Fetch token from GuestTape[7 + IP].
        - If token == ']', increment counter.
        - If token == '[', decrement counter.

## Integration Points in `full_interpreter_v3.bf`
- Place after the Movement Cluster (`<`, `>`).
- Before the final IP increment and Hub reset.

## Verification Plan
- Test with a simple loop: `+++ [ > ++ < - ] > .` (Should output ASCII 6).
- Test nested loops: `++ [ > + [ > + < - ] < - ] >> .`
