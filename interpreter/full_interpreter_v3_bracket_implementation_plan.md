# Detailed Implementation Plan: Recursive Control Flow for v3 Interpreter

## 1. Architectural Integration

The recursive control flow (`[` and `]`) will be integrated into the Range Filter Dispatcher as a new cluster (Cluster 2) or an extension of the existing logic, targeting ASCII 91 (`[`) and 93 (`]`).

## 2. Memory Map Extension
To support bracket scanning without corrupting the core Hub, we will utilize:
- **Cell [4]**: Re-used as the Match Flag / Bracket Counter during scan operations.
- **Symmetric Mirrors [5, 6]**: Used to travel between the Hub, the Instruction Pointer (IP), and the Source Code region.

## 3. The Forward Jump (`[` - ASCII 91)

### Logic Flow:
1. **Match Opcode 91**: Identify `[` via range filter.
2. **Check Guest State**: 
    - Transport VDP [2] to GuestTape.
    - If GuestTape[VDP] != 0, simply increment IP and continue (no jump).
    - If GuestTape[VDP] == 0, initiate **Forward Scan**.
3. **Forward Scan Loop**:
    - Initialize Bracket Counter [4] = 1.
    - Increment IP [1].
    - Fetch token at new IP.
    - If token == `[`: Increment Counter [4].
    - If token == `]`: Decrement Counter [4].
    - Break loop when Counter [4] == 0.
4. **Finalize**: Set IP to current position. Return to Hub.

## 4. The Backward Jump (`]` - ASCII 93)

### Logic Flow:
1. **Match Opcode 93**: Identify `]` via range filter.
2. **Check Guest State**:
    - Transport VDP [2] to GuestTape.
    - If GuestTape[VDP] == 0, simply increment IP and continue (no jump).
    - If GuestTape[VDP] != 0, initiate **Backward Scan**.
3. **Backward Scan Loop**:
    - Initialize Bracket Counter [4] = 1.
    - Decrement IP [1].
    - Fetch token at new IP.
    - If token == `]`: Increment Counter [4].
    - If token == `[`: Decrement Counter [4].
    - Break loop when Counter [4] == 0.
4. **Finalize**: Set IP to current position. Return to Hub.

## 5. Implementation Sequence
1. **Draft the Range Matchers**: Create the logic to isolate ASCII 91 and 93.
2. **Build the VDP-to-Guest Bridge**: Ensure we can check the value of the guest cell before deciding to jump.
3. **Construct the Scanning Engine**: Develop a reusable transport mechanism that allows the IP to move while checking tokens against specific values (91/93).
4. **Unify into `full_interpreter_v3.bf`**: Integrate these blocks before the final IP increment step.
