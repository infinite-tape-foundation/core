# Bracket Logic Integration Plan: v3 Interpreter

The final frontier of the v3 interpreter is the implementation of recursive control flow: `[` and `]`.

## 1. Memory Requirements
To implement bracket jumps, we need additional state cells in the Control Hub to track nesting levels during scans.

- **Nest Level [8]**: Tracks depth of nested brackets during a scan.
- **Scan Direction [9]**: (Optional) Flag for forward vs backward movement.

## 2. The Forward Jump (`[`) - ASCII 91
**Logic**: 
1. Match ASCII 91.
2. Check GuestTape[VDP].
3. If $
eq 0$: Advance IP by 1 and continue.
4. If $= 0$:
    - Set Nest Level = 0.
    - Move IP forward until GuestTape[IP] == `]` AND Nest Level == 0.
    - Every `[` encountered increments Nest Level.
    - Every `]` encountered decrements Nest Level.
    - Set IP to the position of the matching `]`.

## 3. The Backward Jump (`]`) - ASCII 93
**Logic**:
1. Match ASCII 93.
2. Check GuestTape[VDP].
3. If $= 0$: Advance IP by 1 and continue.
4. If $
eq 0$:
    - Set Nest Level = 0.
    - Move IP backward until GuestTape[IP] == `[` AND Nest Level == 0.
    - Every `]` encountered increments Nest Level.
    - Every `[` encountered decrements Nest Level.
    - Set IP to the position of the matching `[`.

## 4. Technical Implementation Challenges
- **The Scan Loop**: We must implement a loop that moves the IP, fetches the character at the new IP, compares it to the target bracket, updates the nest level, and repeats.
- **Symmetric Transport in Scan**: Each step of the scan requires moving from Hub $	o$ GuestTape[7+IP] $	o$ Hub.
- **Pointer Stability**: Ensuring the IP is updated correctly without corrupting other control cells.

## 5. Integration Sequence
1. Update Memory Map documentation.
2. Implement `[` match logic $	o$ Forward Scan $	o$ IP update.
3. Implement `]` match logic $	o$ Backward Scan $	o$ IP update.
4. Verify with nested loops: `++[>+++<-]>
