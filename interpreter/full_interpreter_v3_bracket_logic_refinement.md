# Refinement: v3 Bracket Logic Implementation

To move the `full_interpreter_v3_bracket_draft.bf` from a draft to a functional state, we must concretize the token evaluation logic within the scan loops.

## 1. Forward Jump (`[`) Evaluation
Within the search loop for `[`:
- **Current Token**: Located at Hub [3].
- **Target '[' (91)**: 
    - Subtract 91 from Token.
    - If result is 0, increment Nesting Counter [4].
- **Target ']' (93)**: 
    - Subtract 93 from Token.
    - If result is 0, decrement Nesting Counter [4].

## 2. Backward Jump (`]`) Evaluation
Within the search loop for `]`:
- **Current Token**: Located at Hub [3].
- **Target ']' (93)**: 
    - Subtract 93 from Token.
    - If result is 0, increment Nesting Counter [4].
- **Target '[' (91)**: 
    - Subtract 91 from Token.
    - If result is 0, decrement Nesting Counter [4].

## 3. The Zero Check Paradox
In Brainfuck, the jump `[` only occurs if the current cell is 0. However, BF's primary loop `[...]` executes *while* non-zero. To implement "If Zero then Scan", we must:
1. Copy Guest Value to Temp A [4].
2. Use a flagging mechanism: 
   - Set Flag = 1.
   - While Temp A != 0: { Flag = 0; Temp A = 0; }
   - Now, while Flag != 0: { Execute Scan }.

This ensures the scan only triggers on a zero value.
