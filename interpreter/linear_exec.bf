/*
 * The Linear Executor: Phase I of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode
 * [2] : Virtual Data Pointer (VDP) - Absolute address on Guest Tape
 * [3] : Temp / Comparison Cell
 * [4] : Source Base Offset
 * [5+] : Source Code and Guest Workspace
 */

/* Initialize IP=0, VDP=5 (Guest Tape Start), SourceBase=5 */
+++++ > +++++ <

/* MAIN LOOP */
[ 
    /* 1. FETCH: Copy cell at (SourceBase + IP) to Opcode [1] */
    /* Move from [0] to [SourceBase + IP] */
    > > > > > 
    /* We are now at [5]. Use IP [0] to offset */
    < < < < <
    [
        - 
        > > > > > 
        /* This is a simplification; actual indexed fetch in BF requires a shift loop */
        < < < < <
    ]
    
    /* Placeholder Fetch for structural validation: Assume we read current cell */
    > > > > >
    
    /* 2. DISPATCHER */
    /* Current Opcode is now in the active cell */
    
    /* Logic: If Opcode == '>' (62) then VDP++ */
    /* This would typically use a comparison primitive */
    
    /* For this phase, we refine the memory layout and ensure movement works */
    
    /* Advance IP [0] */
    < < < < <
    + 
    > > > > >
    
    /* Loop termination condition: Stop when opcode is 0 or EOF marker */
    [ - ]
]
