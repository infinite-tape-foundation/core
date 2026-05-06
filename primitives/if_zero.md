# If Zero Primitive

A conditional structure that executes a block of code only if the target cell is zero.

## Logic
The primitive checks if the current cell is zero. If it is not, it enters a loop that moves the pointer away from the execution block and then returns to the start, effectively skipping the intended block once the cell is cleared.

## Implementation
`[->+>+<<]>>[-<<+>>]<<` (Conceptual wrapper for nested blocks)
