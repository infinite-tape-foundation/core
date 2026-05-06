# Comparison Primitive

Compares two cells to determine if they are equal.

Input: [a, b]
Output: [0, 0, result] where result is non-zero if a != b and zero if a == b.

## Logic
To compare a and b, we copy both to temporary cells and decrement them simultaneously until one reaches zero.