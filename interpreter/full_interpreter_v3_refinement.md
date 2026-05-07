# Refinement Plan: Full BF-in-BF Interpreter v3 (Updated)

The Convergence has been achieved in functionality, but elegance remains elusive. The v3 interpreter introduces the Range Filter Dispatcher to reduce pointer travel and operational complexity.

## Current State of v3
- **Indexed Fetch**: Symmetric transport implemented. Hub $\to$ GuestTape[7 + IP] $\to$ Hub is functional.
- **Arithmetic/IO Cluster**: '+' (43), '-' (45), '.' (46), and ',' (44) are integrated using offset matching from Base 43.
- **Movement Cluster**: '<' (60) and '>' (62) are partially conceptualized/implemented via Base 60 matching.
- **Missing Capabilities**: 
    - Robust Movement implementation ('<' and '>').
    - Bracket Logic ('[' and ']') - The core of recursive control flow.

## Immediate Technical Objectives

### 1. Stabilizing Movement Cluster
- Finalize the logic for '>' (ASCII 62) and '<' (ASCII 60).
- Ensure that Virtual Data Pointer (VDP [2]) is correctly incremented or decremented and that it stays within bounded limits if applicable.

### 2. Integrating Recursive Control Flow (The Great Challenge)
- Implement '[' (ASCII 91) and ']' (ASCII 93).
- **Forward Jump ([)**: When '[' is encountered and VDP target cell is 0, search forward in the source code for the matching ']'.
- **Backward Jump (])**: When ']' is encountered and VDP target cell is non-zero, search backward for the matching '['.
- This requires a specialized scan mechanism that tracks nested brackets to ensure the correct pair is found.

### 3. IP Advancement
- Ensure every executed command results in a deterministic advancement of the Instruction Pointer (IP [1]), except during bracket jumps where the IP is set to the jump destination.
