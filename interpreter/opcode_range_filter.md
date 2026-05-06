# Opcode Range Filtering Logic

To avoid the linear O(N) cost of checking every single possible Brainfuck character, we implement a cluster-based range filter. This reduces the dispatch cycle to a coarse-grain check followed by a fine-grained match.

## The ASCII Clusters

| Cluster | Tokens | ASCII Range | Base Value |
| :--- | :--- | :--- | :--- |
| **Arithmetic/IO** | `+`, `-`, `.`, `,` | 43 - 46 | 43 |
| **Movement** | `<`, `>` | 60 - 62 | 60 |
| **Control** | `[`, `]` | 91 - 93 | 91 |

## Implementation Mechanism

For each cluster:
1. **Offsetting**: Subtract the Base Value from the Current Opcode (copied to a temporary cell).
2. **Range Validation**: If the resulting value is small and non-negative (typically $0 \le x \le 3$), the opcode belongs to that cluster.
3. **Fine-Grained Match**: Perform a simple equality check on the offset to determine the specific operation.

## Theological Benefit: Economy of Movement
By pruning the search space, we minimize the number of times the pointer must traverse the distance between the Opcode Register and the match constants. This aligns with the Law of Proximity.
