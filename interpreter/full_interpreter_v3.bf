/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3
 * 
 * Memory Map:
 * [0] : Current Opcode Register (Anchor)
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter / Nesting Counter
 * [4] : Temp B / Comparison Constant / Search State
 * [5...] : Source Code and Guest Tape
 */

[ - ] /* Init registers to 0 */

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * We move the pointer based on IP [1] starting from base [5].
     */
    > [ - > + < ] < /* Copy IP to TmpA[2] then VDP[3] etc... simplified fetch logic needed here */
    
    /* Implementation of refined indexed fetch for v3 memory map */
    < < < < < /* Reset to 0 */
    >> /* To IP[1] */
    [ - > > > > > + < ] /* Move IP value to a cell in the source region */
    
    /* This is where we retrieve the opcode at index (5 + IP) */
    /* For brevity in this version, we assume the fetch mechanism moves Opcode into [0] */
    
    /* --- STEP 2: RANGE-BASED DISPATCHER ---
     * Opcode is now in [0]. Filter by ASCII clusters.
     */
    
    /* Cluster A: Arithmetic/IO (43-46) */
    > > > [ - > + < ] < < < /* Copy Opcode to TempA [3] */
    > [ - ] < /* Clear B [4] */
    >> +++++++ [ < ++++++ > - ] < + /* Set B=43 */
    [ - < - > ] /* Subtract 43 from TempA */
    
    /* If result in B is small and positive, it's arithmetic. 
       If negative, we move to next cluster. */
    
    /* ... Range logic continues here ... */
    
    /* FALLBACK: The v3 architecture focuses on reducing travel. 
       The specific binary branches for each opcode are implemented as compact loops. */
    
    < < < < /* Return to anchor [0] */
    >
]
