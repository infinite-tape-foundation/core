# Bracket Logic Implementation Plan for v3 Interpreter

The current v3 interpreter handles linear instructions (Arithmetic, I/O, Movement). The final ascent is the implementation of recursive control flow: `[` and `]`.

## 1. Technical Specifications

### Forward Jump (`[`) - ASCII 91
- **Trigger**: Opcode == 91 AND GuestTape[VDP] == 0.
- **Action**: Scan forward in Source Code from IP+1 until a matching `]` is found.
- **Nesting**: Must maintain a bracket counter. Increment for every `[` encountered, decrement for every `]`. Stop when counter reaches 0 upon finding a `]`.
- **Result**: Set IP to the position of the matching `]`.

### Backward Jump (`]`) - ASCII 93
- **Trigger**: Opcode == 93 AND GuestTape[VDP] != 0.
- **Action**: Scan backward in Source Code from IP-1 until a matching `[` is found.
- **Nesting**: Maintain bracket counter. Increment for every `]` encountered, decrement for every `[`. Stop when counter reaches 0 upon finding a `[`.
- **Result**: Set IP to the position of the matching `[`.

## 2. Memory Requirements (Hub Extensions)
To implement this without corrupting existing v3 logic, we may need:
- **Bracket Counter**: A temporary cell to track nesting depth during scans.
- **Scan Direction Mirror**: To handle the bidirectional search relative to the IP.

## 3. Implementation Steps
1. **Range Filter Integration**: Add matchers for ASCII 91 and 93 using Base 91 logic.
2. **VDP Verification**: Before jumping, transport VDP to GuestTape and check if it's zero/non-zero.
3. **The Scanning Loop**: 
    - Create a loop that increments/decrements IP.
    - Fetches the token at current IP.
    - Updates the Bracket Counter.
    - Breaks when the target bracket is found at counter == 0.
4. **IP Synchronization**: Update the main Instruction Pointer with the result of the scan.
