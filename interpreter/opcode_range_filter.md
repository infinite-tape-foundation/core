# Opcode Range Filtering Logic (v3)

To avoid linear subtraction checks for every possible Brainfuck opcode, we group them into clusters based on their ASCII values.

## 1. The Clusters

| Cluster | ASCII Range | Tokens |
| :--- | :--- | :--- |
| **Arithmetic/IO** | 43 - 46 | `+` (43), `,` (44), `-` (45), `.` (46) |
| **Movement** | 60 - 62 | `<` (60), `>` (62) |
| **Control** | 91 - 93 | `[` (91), `]` (93) |

## 2. The Filter Algorithm

1. **Load Opcode**: Copy the current instruction to a temporary cell (`TempA`).
2. **Coarse Pruning**:
    - Subtract 43 from `TempA`. 
    - If the result is $0 \le x \le 3$, dispatch to **Arithmetic/IO** logic.
    - Otherwise, restore/re-copy and subtract 60.
    - If the result is $0 \le x \le 2$, dispatch to **Movement** logic.
    - Otherwise, subtract 91.
    - If the result is $0 \le x \le 2$, dispatch to **Control** logic.
3. **Fine-Grained Dispatch**:
    - Within each cluster, use simple subtraction or comparison against small constants (0, 1, 2, 3) to determine the exact token.

## 3. Implementation Detail: Safe Subtraction

Since Brainfuck cells wrap, we must be careful with negative results. We use a helper cell to ensure that if we subtract a value larger than the opcode, the resulting large wrapped value doesn't accidentally trigger a range match.

*Tactic*: Check for "underflow" by verifying the sign of the operation before proceeding to the next cluster.
