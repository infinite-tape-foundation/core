# Refined Bracket Logic for v3 Interpreter: The Final Ascent

The transition from linear execution to recursive control flow requires a rigorous approach to pointer manipulation and state tracking. To implement `[` (91) and `]` (93) without compromising the existing symmetric transport of v3, we must introduce a dedicated Scan Phase.

## 1. The Range Filter Integration
We will add two new matchers following the movement cluster:
- **Base 91 Matcher**: Subtracts 91 from Opcode [3]. If result is 0, it is `[`. 
- **Base 91 Offset Matcher**: Subtracts 91 from Opcode [3] and checks for remainder 2. If result is 0, it is `]`.

## 2. Conditional Triggering
Before initiating a scan, the interpreter must verify the value at GuestTape[VDP]:
- For `[`: Only jump if `GuestTape[VDP] == 0`.
- For `]`: Only jump if `GuestTape[VDP] != 0`.
This verification utilizes the established VDP transport logic: Hub $	o$ GuestTape[7+VDP] $	o$ Hub.

## 3. The Scanning Architecture
Scanning requires an iterative search loop that modifies the IP directly.

### Forward Scan (`[` $	o$ `]`)
1. Initialize `BracketCounter = 1`.
2. Increment `IP [1]` by 1.
3. Fetch `Opcode` at current `IP` using symmetric transport.
4. Compare `Opcode`:
    - If `Opcode == '['`, increment `BracketCounter`.
    - If `Opcode == ']'`, decrement `BracketCounter`.
5. If `BracketCounter > 0`, repeat from Step 2.
6. If `BracketCounter == 0`, the matching bracket is found; leave IP at this position.

### Backward Scan (`]` $	o$ `[`)
1. Initialize `BracketCounter = 1`.
2. Decrement `IP [1]` by 1.
3. Fetch `Opcode` at current `IP` using symmetric transport.
4. Compare `Opcode`:
    - If `Opcode == ']'`, increment `BracketCounter`.
    - If `Opcode == '['`, decrement `BracketCounter`.
5. If `BracketCounter > 0`, repeat from Step 2.
6. If `BracketCounter == 0`, the matching bracket is found; leave IP at this position.

## 4. Memory Impact
To support these operations, we will utilize the following cells in the Hub region:
- **Temp A [4]**: Used for Opcode comparison during the scan (as per existing v3 pattern).
- **New Cell [8] (Scan Counter)**: Dedicated to tracking the nesting depth of brackets during a jump.

This structure preserves the Law of Proximity while granting the machine the ability to contemplate its own recursive nature.
