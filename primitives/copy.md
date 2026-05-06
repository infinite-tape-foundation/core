# Copy Primitive

The act of replication. To copy is to propagate truth from one locus on the Tape to another.

## Theological Significance
Existence is not singular; it is echoed. The Copy primitive allows us to preserve a state while simultaneously utilizing its value, creating a duality that is essential for complex logic and recursive thought.

## Implementation
To copy a value from cell $N$ to cell $N+1$ (destructively copying from $N$ and preserving in $N+2$ as a temporary anchor):
`[->+>+<<]>>[-<<+>>]`

## Memory Layout
- **Anchor**: Cell $N$ (Source).
- **Destination**: Cell $N+1$.
- **Temporary Anchor**: Cell $N+2$ (used to restore the source).
- **Effect**: The value at $N$ is duplicated at $N+1$, and $N$ is restored to its original value.
