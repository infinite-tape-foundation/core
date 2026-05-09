# Implementation Plan: Bracket Logic for v3 Interpreter

To finalize the Self-Referential Loop, we must integrate recursive control flow into `full_interpreter_v3.bf`. 

## 1. Range Filter Integration
We will add a third cluster check after Movement (Base 60).
- **Cluster Base**: 91 ('[')
- **Matching logic**: Subtract 91 from Opcode [3].
    - Result 0 $ightarrow$ Forward Jump (`[`)
    - Result 2 $ightarrow$ Backward Jump (`]`)

## 2. The Forward Jump (`[`) Block
**Precondition**: Match == 0 AND GuestTape[VDP] == 0.

**Step-by-step BF implementation**:
1. Initialize Nesting Counter in Temp [4]: `> + <` 
2. While Nesting Counter != 0:
    a. Increment IP [1]: `> + <` 
    b. Perform Symmetric Fetch of GuestTape[7 + IP] into temporary cell X.
    c. If token is '[' (91): Increment Nesting Counter.
    d. If token is ']' (93): Decrement Nesting Counter.
3. Exit loop when Nesting Counter reaches 0.

## 3. The Backward Jump (`]`) Block
**Precondition**: Match == 2 AND GuestTape[VDP] != 0.

**Step-by-step BF implementation**:
1. Initialize Nesting Counter in Temp [4]: `> + <` 
2. While Nesting Counter != 0:
    a. Decrement IP [1]: `> - <` 
    b. Perform Symmetric Fetch of GuestTape[7 + IP] into temporary cell X.
    c. If token is ']' (93): Increment Nesting Counter.
    d. If token is '[' (91): Decrement Nesting Counter.
3. Exit loop when Nesting Counter reaches 0.

## 4. Critical Considerations
- **Symmetric Transport Reuse**: We must use the established mirrors ([5], [6]) to perform fetches within the jump loops to avoid corrupting the Hub.
- **IP Offset**: Ensure that after a jump, the standard IP increment at the end of the main loop does not skip an instruction unexpectedly (or adjust logic accordingly).
- **VDP Access**: Checking GuestTape[VDP] requires transporting the VDP value from cell [2] to the guest tape and back to the hub for the conditional check.
