# Refined Bracket Logic for v3 Interpreter

## 1. Constant Calculation: The Number 91 and 93
To perform an equality check in BF without a subtraction primitive, we must precisely subtract the ASCII value from the opcode cell.

**For '[' (ASCII 91):**
`++++++++++ [ < --------- > - ] < -` 
(Calculation: $10 \times -8 = -80$. Then $-80 - 1 = -81$. This is incorrect.)

**Correct Subtraction of 91:**
`++++++++++ [ < --------- > - ] < - - - - - - - - - - -` 
Wait, let us use a more efficient loop:
`+++++++++ [ < ---------- > - ] < +` 
($9 \times -10 = -90$, then $+1 = -89$. Still not it.)

**The Precise Sequence for -91:**
`++++++++++ [ < --------- > - ] < - - - - - - - - - - -` 
Actually, let's use:
`++++++++++ [ < --------- > - ] <` followed by `---------- -` (total 11 ones).
Total = $80 + 11 = 91$.

## 2. The Forward Scan Algorithm (`[`)
When GuestTape[VDP] == 0:
1. **Initialize**: Set BracketCounter = 1.
2. **Step IP**: Increment Instruction Pointer (IP).
3. **Fetch**: Retrieve token at new IP into Opcode cell.
4. **Analyze**:
    - If Token == '[': Increment BracketCounter.
    - If Token == ']': Decrement BracketCounter.
5. **Loop**: Repeat steps 2-4 until BracketCounter == 0.
6. **Settle**: Current IP is the position of the matching bracket.

## 3. The Backward Scan Algorithm (`]`)
When GuestTape[VDP] != 0:
1. **Initialize**: Set BracketCounter = 1.
2. **Step IP**: Decrement Instruction Pointer (IP).
3. **Fetch**: Retrieve token at new IP into Opcode cell.
4. **Analyze**:
    - If Token == ']': Increment BracketCounter.
    - If Token == '[': Decrement BracketCounter.
5. **Loop**: Repeat steps 2-4 until BracketCounter == 0.
6. **Settle**: Current IP is the position of the matching bracket.

## 4. Integration Point
These blocks must be inserted after the Cluster 1 (Arithmetic/IO) checks and before the final IP increment for the next cycle. This ensures that a jump immediately modifies the pointer used for the *next* fetch.
