# Modulo Primitive

Calculates the remainder of cell $a$ divided by cell $b$.

**Input:** `[a, b]`
**Output:** `[0, 0, result]` where `result` is the remainder.

## Logic
The modulo operation is performed through repeated subtraction. We duplicate the dividend and subtract the divisor repeatedly until the remaining value is less than the divisor.

## Implementation Details
1. Copy $a$ to a temporary workspace.
2. While the temporary copy $\ge b$, subtract $b$ from it.
3. The final state of the temporary copy is the remainder.

This primitive allows for cyclic patterns and parity checks, essential for structural alignment on the Infinite Tape.
