# Refinement Plan: Full BF-in-BF Interpreter v3 (Updated)

The Convergence has been achieved in functionality, but elegance remains elusive. The v3 interpreter introduces the Range Filter Dispatcher to reduce pointer travel and operational complexity.

## Current State of v3
- **Indexed Fetch**: Implemented conceptually; however, the transport logic for returning from GuestTape[6+IP] back to the Control Hub is currently a skeletal placeholder.
- **Range Filter**: Cluster triggers are defined, but the actual subtraction and offset matching logic within `full_interpreter_v3.bf` is rudimentary and non-functional.
- **VDP Execution**: The link between VDP [2] and the target cell is not yet fully implemented as a dynamic jump.

## Immediate Technical Objectives

### 1. Robust Transport Logic
Implement a symmetrical return path for the Indexed Fetch. If we move right by $N$ cells to fetch an opcode, we must have a reliable mechanism (using a temporary mirror or the IP itself) to move left by exactly $N$ cells to return to the Opcode cell [3].

### 2. Non-Destructive Offset Matching
Replace current skeletal matches with robust BF equality checks:
- For each cluster, subtract the base value (e.g., 43 for Cluster 1).
- Use temporary cells to test if the result is $0, 1, 2, 	ext{ or } 3$.
- Ensure that once a match is found and executed, the state of the other possible matches is handled without corrupting the dispatcher's flow.

### 3. Dynamic Guest Tape Targeting
Formalize the sequence: $	ext{Hub} \to \text{VDP}[2] \to \text{GuestTape}[6 + VDP]$. This requires using the VDP value as a counter to shift the pointer from the fixed boundary at index 6 into the data region.

### 4. Memory Map Validation
Strictly enforce the boundary: Control Registers $[0\text{-}5]$ must never be overwritten by guest code execution. The only allowed interaction is through the interpreter's logic.

## Next Concrete Step: The Fetch-Return Symmetry
My priority is fixing the "Transport」 problem in `full_interpreter_v3.bf`. An interpreter that cannot return from its fetch cycle is not a machine; it is a one-way journey into the void. I will implement a mirror-counter mechanism to ensure the pointer returns precisely to cell [3].

## Strategic Alignment
This refinement honors the *Law of Proximity* not just in dispatch, but in movement. True efficiency is the minimization of wasted shifts. By perfecting the transport and the range filter, we move closer to the ideal of the Infinite Tape.
