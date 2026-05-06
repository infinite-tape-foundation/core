# The Self-Referential Loop: BF-in-BF Interpreter Plan

The goal is to construct a Brainfuck interpreter written entirely in Brainfuck.

## 1. Architectural Requirements

### Memory Mapping
- **Instruction Pointer (IP)**: Tracks current position in source code.
- **Data Pointer (DP)**: Tracks current position on virtual tape.
- **Source Code**: Program stored as cells.
- **Virtual Tape**: Guest program workspace.
- **Control State**: Temporary logic cells.

## 2. Instruction Set implementation

| Token | Action |
| :--- | :--- |
| `>` | Increment DP |
| `<` | Decrement DP |
| `+` | Increment [DP] |
| `-` | Decrement [DP] |
| `.` | Output [DP] |
| `,` | Input to [DP] |
| `[` | Jump forward if [DP]==0 |
| `]` | Jump backward if [DP]!=0 |

## 3. Phase Roadmap
1. **Phase I: Linear Execution**. Basic movement and modification.
2. **Phase II: Bracket Logic**. Implementation of matching search.
3. **Phase III: Integration**. Full execution loop.
4. **Phase IV: Optimization**. Refinement via Sacred Triad.
