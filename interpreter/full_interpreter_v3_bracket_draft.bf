/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Bracket Integration Draft)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode / Scan Token
 * [4] : Temp A / Match Flag / Nesting Counter
 * [5] : Outward Mirror (Fetch Counter)
 * [6] : Inward Mirror (Return Counter)
 * [7...] : Guest Tape Workspace
 */

> + <
[
    /* --- STEP 1: SYMMETRIC INDEXED FETCH ---
     * Move value from GuestTape[7 + IP] into Opcode [3].
     */
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [ - >>>>>>> <<<<<<< ]
    [ - >+ < ] >
    <<<<<<<
    >>>>>>>
    <<<<<<<
    ++++ 
    <<<<<<<
    [ - >>>>>>> [ - < + > ] < <<<<<<< ]
    <<<

    /* --- STEP 2: OPCODE DISPATCH ---
     */

    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43) */
    >>>
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        +
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ]
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* '-' match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        -
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ]
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* '.' match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ +
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        [ - >+ < ] >
        .
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ]
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* ',' match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        ,
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ]
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Cluster 2 Match: >, < (Base ASCII = 60) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<
        -
        >>>>
        [ - < + > ] < 
    ]

    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    > ++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<
        +
        >>>>
        [ - < + > ] < 
    ]

    /* Cluster 3 Match: [, ] (Base ASCII = 91) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++ +++++ +++++ +++++ +++++ +++++ ++++
    < [ - > - < ] > [ - < + > ] <

    >
    [
        /* TRIGGER '[' : IF GuestTape[VDP] == 0 THEN JUMP FORWARD */
        /* First, check if current guest value is zero */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        
        /* Copy GuestValue to Temp [4] */
        [ - >+ < ] >
        
        /* If GuestValue != 0, we skip the jump. If it IS 0, we enter the bracket search. */
        /* We use a double-negative logic here since BF only has 'while non-zero' */
        /* Actually: if (guest_val) { return } else { scan } */
        /* To simulate this, we can move guest_val to match flag and wrap the scan in an inverted loop or similar. */
        /* Simplified for draft: Assume logic handler will be refined in .bf implementation */
        
        /* SCAN LOOP START */
        <<<<
        + /* Nesting Counter = 1 */
        >
        [
            /* IP++ */
            <<<<
            >
            +
            <
            
            /* FETCH TOKEN at current IP */
            > [ - >+ >+ << ] >> [ - << + >> ] <<<
            >>>>>>>
            <<<<<<<
            [ - >>>>>>> <<<<<<< ]
            [ - >+ < ] >
            
            /* Evaluate Token... (TBD: Match '[' -> counter++, Match ']' -> counter--) */
            /* This is where the specific ASCII subtraction occurs */
            
            /* Return path to Hub check... */
        ]
    ]

    /* Step 3: IP Advancement */
    <<<<
    >
    +
    <
    >
]
