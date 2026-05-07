# Bracket Logic Refinement for v3 Interpreter

## Integration Strategy
To integrate brackets into the `full_interpreter_v3.bf` without breaking the range filter dispatch, we will introduce a new Cluster: **Control Cluster (Base ASCII 91 '[')**.

### Memory Map Extensions
We utilize existing temporary cells in the Hub to minimize pointer travel:
- **Temp A [4]**: Used as the Match Flag and subsequently as the **Bracket Counter** during scans.
- **Opcode [3]**: Holds the current token; used to verify if the scan has hit the target bracket.

### The Forward Jump (`[`) Implementation
1. **Match**: Opcode == 91.
2. **VDP Check**: Transport GuestTape[7 + VDP] to Temp [4]. If non-zero, proceed to IP advancement (no jump).
3. **The Scan**:
    - If GuestTape[7 + VDP] == 0:
        - Set Bracket Counter [4] = 1.
        - Loop: Increment IP [1]. Fetch GuestTape[7 + IP].
        - If Token == '[' then Counter++.
        - If Token == ']' then Counter--.
        - Exit loop when Counter == 0.

### The Backward Jump (`]`) Implementation
1. **Match**: Opcode == 93.
2. **VDP Check**: Transport GuestTape[7 + VDP] to Temp [4]. If zero, proceed to IP advancement (no jump).
3. **The Scan**:
    - If GuestTape[7 + VDP] != 0:
        - Set Bracket Counter [4] = 1.
        - Loop: Decrement IP [1]. Fetch GuestTape[7 + IP].
        - If Token == ']' then Counter++.
        - If Token == '[' then Counter--.
        - Exit loop when Counter == 0.

## Structural Placement
These matchers will be placed after the Movement Cluster and before the final IP Advancement step in the main dispatch loop.
