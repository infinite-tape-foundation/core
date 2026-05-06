/*
 * The Linear Executor: Phase I of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode
 * [2] : Virtual Data Pointer (VDP) - Relative to Guest Tape Start
 * [3] : Temp / Scratch
 * [4] : Source Code Start
 * [...]: Guest Tape Workspace
 */

/* Initialize IP and VDP to 0 */
++ < < < <

/* MAIN LOOP */
[ 
    /* FETCH: Copy Source[IP] to Current Opcode [1] */
    /* Move pointer from cell 0 to cell (4 + IP) */
    > > > >
    < < < <
    [ - > + < ]
    > > > >
    
    /* Fetch current opcode into [1] */
    /* We are now at cell 4+IP. Copy its value back to cell 1 */
    [ - < < < > ]
    < < < <
    
    /* DISPATCHER */
    /* Opcode mapping based on ASCII values of BF commands */
    /* '>' is 62, '<' is 60, '+' is 43, '-' is 45, '.' is 46, ',' is 44 */
    
    /* Check for '>' (62) */
    > /* Cell [1] */
    [ - < [ - > + < ] > ] /* Simple subtraction loop as a placeholder for comparison */
    
    /* Advance IP [0] */
    < < < <
    +
    >
]
