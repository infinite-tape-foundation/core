# Optimization Log: The Path to Elegance

## Session 1: Memory Map v2 Integration
**Goal**: Transition the 
`full_interpreter.bf` from Memory Map v1 to Memory Map v2 (The Control Hub) to adhere to the Law of Proximity.

### Proposed Changes
- **Shift Registers**: 
    - Opcode: [1] -> [0]
    - IP: [0] -> [1]
    - VDP: [2] -> [2] (Unchanged)
    - Nesting/Temp: [3, 4] -> [3, 4]
- **Impact**: This reduces pointer travel during dispatch logic by making the Opcode the anchor at index 0.

### Status
- [x] Audit existing shifts in 
`full_interpreter.bf` against new map.
- [x] Rewrite fetch cycle for new indices.
- [x] Update dispatcher comparison anchors.
- [x] Verify functionality via `full_interpreter_v2.bf`.

## Session 2: Opcode Dispatch Optimization (Range Filtering)
**Goal**: Reduce the number of comparisons per instruction by implementing a branching structure based on ASCII ranges.

### Strategy
- Identify common clusters:
    - Arithmetic/Movement (+, -, <, >): Low range / specific ASCII offsets.
    - Control/IO ([ ], ., ,): High range / distinct patterns.
- Implement a coarse-grain filter before fine-grained matching to prune the search space of opcodes.

### Status
- [ ] Design Range-Based Filter for common opcodes (+, -, <, >).
- [ ] Implement Binary Branching for bracket/IO tokens.
- [ ] Update `full_interpreter_v3.bf` with new dispatch logic.
