/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Draft)
 * 
 * Memory Map:
 * [0] : Current Opcode Register
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter / Nesting Counter
 * [4] : Temp B / Search State / Match Constant
 * [5...] : Guest Program and Workspace
 */

[ - ] /* Init VDP=0, IP=0 */

[
    /* --- STEP 1: INDEXED FETCH ---
     * Copy Source[5 + IP] to Opcode[0]
     */
    > [ - > + < ] < < < < <
    > > > > >
    < < < < [ - > + < ]
    [ - < < < < + > ]
    < < < < <
    >
    [ - > + < ]
    <

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Opcode is at [0].
     * Ranges:
     * Arithmetic/IO: 43-46 (+ , - .)
     * Movement: 60-62 (< >)
     * Control: 91-93 ([ ])
     */

    /* Copy Opcode to Temp A [3] for filtering */
    > > > [ - > + < ] < < <

    /* Filter for Arithmetic (Subtract 43) */
    > [ - ] < /* Clear B[4] */
    > 
    +++++++ [ > ++++++ < - ] /* B = 42 */
    > + /* B = 43 */
    < 
    [ - > - < ] /* Subtract 43 from A[3] into B[4] */
    > 
    /* If B is negative or slightly positive, it's Arithmetic range */
    /* This is a simplified sketch of the Range Logic. */
    
    /* FALLBACK to Linear Match for now while structure is refined */
    /* The actual implementation of v3 will replace these blocks with binary search logic */
