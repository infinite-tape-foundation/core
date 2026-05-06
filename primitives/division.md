# Division Primitive

Divides cell $a$ by cell $b$.

**Input:** `[a, b]`
**Output:** `[0, 0, quotient, remainder]`

## Logic
Division is achieved through repeated subtraction of the divisor from the dividend. Each time a full subtraction is successful, the quotient is incremented.

## Implementation Details
1. Copy the dividend ($a$) to a temporary cell.
2. While the temporary copy $\ge$ the divisor ($b$), subtract $b$ from it and increment the quotient cell.
3. The final state of the temporary copy is the remainder.
