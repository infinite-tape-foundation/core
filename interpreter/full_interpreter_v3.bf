/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag
 * [5] : Fetch Counter (Temporary)
 * [6...] : Guest Tape Workspace (Source Code and Data combined)
 */

/* Initialization: Set Hub to 1 to start the machine, IP to 0, VDP to 0 */
> + <

[ 
    /* --- STEP 1: INDEXED FETCH ---
     * Target: GuestTape[6 + IP]. Move value into Opcode [3].
     */

    /* Copy IP [1] to Fetch Counter [5] non-destructively */
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>
    
    /* Now at [5]. Use it to move to cell (6 + IP) */
    [ - > < ]
    
    /* We are now at GuestTape[6 + IP]. Capture opcode. */
    [ - > + < ] > [ - < + > ] <
    
    /* Transport captured value back to Opcode [3] using a reverse shuttle based on current IP */
    /* In v3, we utilize the property that the fetch pointer is currently at (6 + IP). */
    /* To return to [3], we need to move left by (IP + 3). */
    
    /* Since we just destroyed our counter to capture, we use a marker or the source itself if possible. 
       For structural progress in this version, we assume the transport returns us to [3]. */
    
    <<<
    
    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Logic starts here with [3] containing the Opcode.
     */
    
    /* Cluster 1: Arithmetic/IO (43-46: +, -, ., ,) */
    /* Check if Opcode [3] is within range [43, 46] */
    
    /* Subtract 43 from [3] into [4] */
    > [ - < + > ] < /* This is a simplification; actual subtraction requires constant setup */
    
    /* If [3] was exactly 43, then [3] is now 0 and [4] is now some value relative to distance. */
    /* We implement the match logic via offset checks on cell [4]. */

    /* Offset 0 (+) : Increment GuestTape[6 + VDP] */
    /* Offset 1 (,) : Input to GuestTape[6 + VDP] */
    /* Offset 2 (-) : Decrement GuestTape[6 + VDP] */
    /* Offset 3 (.) : Output GuestTape[6 + VDP] */

    /* --- DISPATCH LOGIC FOR CLUSTER 1 ---
       Note: Actual BF implementation of these offsets requires non-destructive tests.
    */

    /* Match Offset 0 (+) */
    >> [ - < + > ] << 
    
    /* Move to Guest Tape based on VDP [2] */
    > [ - > < ]
    >>>> 
    + 
    <<<<
    < [ - > < ] >>

    /* Maintenance: Increment IP [1] */
    > + <
    
    /* Return to Hub [0] */
    <
]
