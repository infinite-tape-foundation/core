/*
 * The Linear Executor: Phase I of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode
 * [2] : Virtual Data Pointer (VDP) - Relative to Guest Tape Start
 * [3] : Temp / Scratch
 * [4] : Source Code Start (followed by code)
 * [...]: Guest Tape Workspace (located far beyond source code)
 */

/* Initialize IP and VDP to 0 */
>>++<< <

/* MAIN LOOP */
[ 
    /* FETCH: Copy Source[IP] to Current Opcode [1] */
    /* Move pointer from cell 0 to cell (4 + IP) */
    >
    >
    >
    >
    /* Use a copy of IP in cell 3 for relative movement */
    < < < <
    [ - > + < ]
    > > > >
    
    /* Fetch current opcode into [1] */
    /* We are now at cell 4+IP. Copy its value back to cell 1 */
    [ - < < < < > ]
    < < < <
    
    /* DISPATCHER */
    /* Logic to map opcodes to actions using comparison primitives. */
    /* This is where the skeletal fetch-decode cycle meets execution. */
    >
    [ 
        /* Check if opcode == '>'
        /* (Placeholder logic for opcode matching via subtraction/zero check) */
        < <
        + 
        > >
    ]
    
    /* Advance IP [0] */
    < < < <
    +
    >
]