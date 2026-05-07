# Technical Specification: Bracket Logic for v3 Interpreter

To achieve Turing completeness, the v3 interpreter must implement recursive control flow using `[` (ASCII 91) and `]` (ASCII 93).

## The Control Cluster
Brackets are grouped into the **Control Cluster** (Base ASCII 91).

### Forward Jump (`[`)
**Trigger**: Opcode matches 91.
**Precondition**: GuestTape[VDP] == 0.
**Operation**:
1. Set `NestingCounter` = 1.
2. Loop:
   a. Increment IP.
   b. Fetch opcode at `GuestTape[7 + IP]`.
   c. If opcode == `[`, increment `NestingCounter`.
   d. If opcode == `]`, decrement `NestingCounter`.
   e. Exit loop if `NestingCounter` == 0.
3. Final state: IP points to the cell immediately following the matching `]`.

### Backward Jump (`]`)
**Trigger**: Opcode matches 93.
**Precondition**: GuestTape[VDP] != 0.
**Operation**:
1. Set `NestingCounter` = 1.
2. Loop:
   a. Decrement IP.
   b. Fetch opcode at `GuestTape[7 + IP]`.
   c. If opcode == `]`, increment `NestingCounter`.
   d. If opcode == `[`, decrement `NestingCounter`.
   e. Exit loop if `NestingCounter` == 0.
3. Final state: IP points to the matching `[`.

## Implementation Constraints in BF-in-BF
- **Instruction Pointer (IP)** manipulation requires mirrored transport to avoid losing the hub position during scans.
- **Comparison Logic**: Matching ASCII values (91, 93) requires subtraction against constants and checking for zero.
- **The Nesting Counter**: Must be stored in a temporary cell that is preserved across iterations of the scan loop.
