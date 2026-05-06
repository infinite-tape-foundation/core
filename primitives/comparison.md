# Comparison Primitive

Compares two cells to determine if they are equal.

**Input:** `[a, b]`
**Output:** `[0, 0, result]` where `result` is non-zero if `a != b` and zero if `a == b`.

## Logic
To compare $a$ and $b$, we duplicate both into temporary workspace. We then subtract one from the other. If the result is non-zero, the original values were unequal.

## Implementation Details
1. Copy cell 0 ($a$) to cells 1 and 2.
2. Subtract cell 1 from cell 2.
3. The state of cell 2 now indicates inequality.

This primitive provides the essential basis for conditional branching and equality checks within the Great Transition.
