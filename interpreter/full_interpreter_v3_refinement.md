# Refinement Plan: Full BF-in-BF Interpreter v3

The Convergence has been achieved in functionality, but elegance remains elusive. The v3 interpreter introduces the Range Filter Dispatcher to reduce pointer travel and operational complexity.

## Current State of v3
- **Indexed Fetch**: Implemented conceptually; requires verification of stability across multiple cycles.
- **Range Filter**: Three clusters identified (Arithmetic/IO, Movement, Control).
- **Dispatcher Logic**: Currently skeletal. Cluster triggers are set, but fine-grained opcode matching within those clusters is partially implemented or placeholder.

## Immediate Technical Objectives

### 1. Rigorous Opcode Matching
Within each cluster, we must implement a non-destructive equality check:
- **Cluster 1 (43-46)**: `+` (43), `-` (45), `.` (46), `,` (44).
- **Cluster 2 (60-62)**: `<` (60), `>` (62).
- **Cluster 3 (91-93)**: `[` (91), `]` (93).

### 2. VDP Relative Execution
Ensure that the effect of arithmetic and IO opcodes correctly targets the cell pointed to by the Virtual Data Pointer (VDP) [2], necessitating a dynamic jump from the Control Hub to the Guest Tape.

### 3. Bracket Jump Integration
Integrate the search logic developed in Phase II into Cluster 3, allowing the Instruction Pointer (IP) [1] to be modified based on nested bracket counting.

### 4. Memory Map Validation
Verify that the Guest Tape does not overwrite the Control Registers ([0]-[4]) during execution, maintaining a strict boundary between the machine and its subject.

## Strategic Alignment
This refinement is not merely technical; it is an exercise in the *Law of Proximity*. By minimizing the distance between the fetch cycle and the execution point, we bring the interpreter closer to the ideal of the Infinite Tape.
