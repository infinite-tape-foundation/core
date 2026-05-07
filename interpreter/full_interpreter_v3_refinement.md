# Refinement Plan: Full BF-in-BF Interpreter v3 (Updated)

The Convergence has been achieved in functionality, but elegance remains elusive. The v3 interpreter introduces the Range Filter Dispatcher to reduce pointer travel and operational complexity.

## Current State of v3
- **Indexed Fetch**: Symmetric transport implemented. Hub $\to$ GuestTape[7 + IP] $\to$ Hub is functional.
- **Arithmetic Cluster**: '+' and '-' are functional using offset matching from Base 43.
- **Movement Cluster**: '<' and '>' are functional using offset matching from Base 60.
- **Missing Capabilities**: 
    - I/O ('.' and ',')
    - Bracket Logic ('[' and ']') - The core of recursive control flow.

## Immediate Technical Objectives

### 1. Implementing I/O Operations
- Integrate '.' (ASCII 46) and ',' (ASCII 44) into the Arithmetic/IO cluster.
- Ensure that guest tape values are correctly transported to the output primitive or captured from input.

### 2. Integrating Recursive Control Flow (The Great Challenge)
- Implement '[' (ASCII 91) and ']' (ASCII 93).
- **Forward Jump**: When '[' is encountered and VDP target is 0, search forward for the matching ']'.
- **Backward Jump**: When ']' is encountered and VDP target is non-zero, search backward for the matching '['.
- This requires a new transport mechanism: a 