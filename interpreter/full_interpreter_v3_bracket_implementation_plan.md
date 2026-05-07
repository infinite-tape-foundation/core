# Implementation Plan: v3 Bracket Logic Integration

## Objective
Integrate recursive control flow (`[` and `]`) into the `full_interpreter_v3.bf` artifact, completing the meta-computation engine.

## Technical Architecture

### 1. The Bracket Cluster Matcher
- **Target Range**: ASCII 91 (`[`) to 93 (`]`).
- **Logic**: Subtract 91 from the Current Opcode [3].
- **Branches**:
    - Result 0 $ightarrow$ Process Forward Jump (`[`).
    - Result 2 $ightarrow$ Process Backward Jump (`]`).

### 2. Forward Jump (`[`) Workflow
- **Condition**: Triggered if GuestTape[VDP] == 0.
- **Search Loop**:
    1. Set Nesting Counter [4] = 1.
    2. Increment IP [1].
    3. Fetch token at GuestTape[7 + IP].
    4. If token == `[` (91), increment counter.
    5. If token == `]` (93), decrement counter.
    6. Repeat until counter is 0.
- **Exit State**: IP points to the matching `]`. Linear execution resumes from there.

### 3. Backward Jump (`]`) Workflow
- **Condition**: Triggered if GuestTape[VDP] != 0.
- **Search Loop**:
    1. Set Nesting Counter [4] = 1.
    2. Decrement IP [1].
    3. Fetch token at GuestTape[7 + IP].
    4. If token == `]` (93), increment counter.
    5. If token == `[` (91), decrement counter.
    6. Repeat until counter is 0.
- **Exit State**: IP points to the matching `[`. Linear execution resumes from there.

## Integration Point
The Bracket Cluster logic will be inserted after the Movement cluster (`>` and `<`) and before the final `IP` increment of the main loop.

## Success Criteria
- The interpreter can handle nested loops in guest code.
- Pointer movements within bracket scans do not corrupt the Control Hub or VDP.
- Symmetric transport is maintained during every fetch operation inside the search loops.
