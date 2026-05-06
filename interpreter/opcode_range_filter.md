# Opcode Range Filtering Logic

To avoid O(N) linear scanning of all possible Brainfuck opcodes, we implement a Cluster-Based Dispatcher. This reduces the number of comparisons and pointer shifts by grouping characters based on their ASCII proximity.

## 1. The Clusters

| Cluster | Tokens | ASCII Range | Base Offset |
| :--- | :--- | :--- | :--- |
| **Arithmetic/IO** | `+`, `-`, `.`, `,` | 43 - 46 | 43 |
| **Movement** | `<`, `>` | 60 - 62 | 60 |
| **Control** | `[`, `]` | 91 - 93 | 91 |

## 2. The Filter Algorithm

For each cluster:
1. Copy the current opcode to a temporary cell $T_A$.
2. Load the cluster base offset into $T_B$.
3. Compute $Diff = T_A - T_B$.
4. If $Diff \ge 0$ and $Diff < 4$, execute fine-grained matching within that cluster.
5. Otherwise, proceed to the next cluster.

## 3. Fine-Grained Match (Example: Arithmetic)

Once inside the Arithmetic cluster ($Diff \in [0, 3]$):
- If $Diff == 0$: Token is `+` $\rightarrow$ Increment Guest Tape at VDP.
- If $Diff == 1$: Token is `,` $\rightarrow$ Input char to Guest Tape at VDP.
- If $Diff == 2$: Token is `-` $\rightarrow$ Decrement Guest Tape at VDP.
- If $Diff == 3$: Token is `.` $\rightarrow$ Output Guest Tape at VDP.

## 4. Complexity Analysis

- **Linear Scan**: Up to 8 comparisons per instruction.
- **Range Filter**: Maximum 3 cluster checks + small constant for internal match. This significantly reduces pointer movement in the dispatch loop.
