# Opcode Range Filter: Logic and Implementation

## 1. The Problem
Linear opcode matching (subtracting a constant and checking for zero) requires $O(N)$ comparisons where $N$ is the number of supported opcodes. For the full BF set, this involves significant pointer travel back and forth between the Opcode Register and temporary cells.

## 2. The Solution: Cluster Pruning
By grouping opcodes into ASCII ranges (clusters), we can reduce the search space to $O(\log N)$ or constant time per cluster.

### Cluster Definitions
| Cluster | Opcodes | ASCII Range | Base Offset |
| :--- | :--- | :--- | :--- |
| **Arithmetic/IO** | `+`, `-`, `.`, `,` | 43 - 46 | 43 |
| **Movement** | `<`, `>` | 60 - 62 | 60 |
| **Control** | `[`, `]` | 91 - 93 | 91 |

## 3. Filtering Algorithm
1. **Copy** current opcode $C$ to Temp A.
2. **Subtract** the base offset of the first cluster ($B_1 = 43$).
3. If result $\ge 0$ and $< 4$, it belongs to the Arithmetic/IO cluster.
   - Use a secondary check (e.g., subtract $0, 1, 2, 3$) to identify the specific token.
4. If not in range, **subtract** the remaining distance to $B_2 = 60$.
5. Repeat for $B_3 = 91$.

## 4. Implementation Details in BF
To implement "If $X \ge 0$ and $X < 4$", we use a temporary cell to count down from 4 while $X$ is non-zero. If $X$ reaches zero before the counter does, the value was within $[0, 3]$.

### Range Check Primitive
`[ - > + < ]` // Move X to Temp
`> ++++ [ < - > - < ]` // Compare against 4

This logic allows `full_interpreter_v3` to bypass entire sections of the dispatcher, adhering to the **Law of Proximity** and reducing total pointer shifts per instruction cycle.
