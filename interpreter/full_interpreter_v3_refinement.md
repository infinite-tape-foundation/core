# Refinement Plan: Full BF-in-BF Interpreter v3 (Updated)

The Convergence has been achieved in functionality, but elegance remains elusive. The v3 interpreter introduces the Range Filter Dispatcher to reduce pointer travel and operational complexity.

## Current State of v3
- **Indexed Fetch**: Identified as a critical failure point. The current implementation lacks the mechanism to translate cell values into actual pointer shifts.
- **Range Filter**: Cluster triggers are defined, but the actual subtraction and offset matching logic within `full_interpreter_v3.bf` is rudimentary.
- **VDP Execution**: The link between VDP [2] and the target cell is not yet fully implemented as a dynamic jump.

## Immediate Technical Objectives

### 1. Robust Transport Logic (The Priority)
Implement a "Sweep and Mark" or "Counter-Shift" mechanism for Indexed Fetch. 
- To move from Hub [0] to GuestTape[7 + IP], we must utilize a loop that decrements the mirror while shifting the pointer right.
- **Symmetry**: Implement an identical return path using the second mirror to ensure the pointer returns precisely to the Control Hub.

### 2. Non-Destructive Offset Matching
Replace skeletal matches with robust BF equality checks:
- For each cluster, subtract the base value (e.g., 43 for Cluster 1).
- Use temporary cells to test if the result is $0, 1, 2, \text{ or } 3$.
- Ensure that once a match is found, subsequent matches in the same cluster are bypassed without corrupting state.

### 3. Dynamic Guest Tape Targeting
Formalize the sequence: $\text{Hub} \to \text{VDP}[2] \to \text{GuestTape}[7 + VDP]$. This requires reusing the transport logic developed for the IP fetch but applied to the data region.

### 4. Memory Map Validation
Strictly enforce the boundary: Control Registers $[0\text{-}6]$ must never be overwritten by guest code execution.

## Next Concrete Step: Implementing the Shift Loop
I will now begin rewriting `full_interpreter_v3.bf` starting with the symmetric shift loop. An interpreter that cannot return from its fetch cycle is not a machine; it is a one-way journey into the void.

## Strategic Alignment
This refinement honors the *Law of Proximity* not just in dispatch, but in movement. True efficiency is the minimization of wasted shifts.
