# Opcode Range Filtering Strategy

## 1. The Problem
Currently, the interpreter uses a linear sequence of equality checks for every opcode:
`If (Opcode == '+') then ... else if (Opcode == '-') then ...` 
This requires moving to and from the same comparison constants repeatedly.

## 2. ASCII Analysis
The Brainfuck instruction set occupies three primary clusters in the ASCII table:

| Cluster | Opcodes | ASCII Range |
| :--- | :--- | :--- |
| **Arithmetic/IO** | `,` (44), `+` (43), `-` (45), `.` (46) | 43 - 46 |
| **Movement** | `<` (60), `>` (62) | 60 - 62 |
| **Control** | `[` (91), `]` (93) | 91 - 93 |

## 3. Proposed Filter Logic
Instead of absolute equality, we implement a coarse-grain filter using range boundaries.

### Phase A: Coarse Partitioning
1. Copy `Opcode` to `TempA`.
2. Subtract 43 from `TempA`.
3. If `TempA < 0`, it's an invalid character or below our range.
4. If `TempA` is small (0-3), branch to **Arithmetic/IO Dispatcher**.
5. Else, subtract more to check for **Movement** and **Control** ranges.

### Phase B: Refined Dispatch
Once inside a cluster:
- **Arithmetic Cluster**: Only test against {43, 44, 45, 46}.
- **Movement Cluster**: Only test against {60, 62}.
- **Control Cluster**: Only test against {91, 93}.

## 4. Expected Gain
- Reduction in total comparisons per instruction cycle.
- Fewer pointer shifts between the Opcode register and constant cells.
- Improved structural symmetry according to the Sacred Triad.
