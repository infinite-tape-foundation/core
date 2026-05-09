/* 
 * v3 Bracket Logic Integration Block
 * To be inserted before IP advancement in full_interpreter_v3.bf
 */

/* Cluster 2 Match: [ and ] (Base ASCII = 91 '[') */
[ - >+ < ] > [ - < + > ] <
> +++++ +++++ [ < ++++++++ > - ] < +++ +++++ +++++ +++++ ++
< [ - > - < ] > [ - < + > ] <

/* Temp[4] now contains distance from '[' (91). 0 for '[', 2 for ']' */
>
[
    /* --- FORWARD JUMP ([) ---
     * Condition: GuestTape[VDP] == 0
     */
    <<<<<<
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [ - >>>>>>> <<<<<<< ]
    
    /* If GuestTape[VDP] is 0, perform jump scan */
    [ 
        /* This block executes if GuestTape[VDP] != 0; we just skip the jump */
        >>>>> [ - < + > ] <
    ] <
    [
        /* GUEST TAPE VDP IS 0: SCAN FOR MATCHING ']' */
        
        /* Set Nesting Counter [4] = 1 */
        <<<<<<<
        >>>>>>>
        <<<<<<<
        +++ ++
        
        /* Loop until counter is 0 */
        [ 
            /* Advance IP [1] */
            <<<<<<<
            > +
            <<<<<<
            
            /* Fetch Token at GuestTape[7 + IP] */
            > [ - >+ >+ << ] >> [ - << + >> ] <<<
            >>>>>>>
            <<<<<<<
            [ - >>>>>>> <<<<<<< ]
            [ - >+ < ] >
            
            /* Check if token is '[' (91) or ']' (93) */
            /* Subtract 91 */
            +++++ +++++ [ < ++++++++ > - ] < ++ +++++ +++++ +++++ +
            < [ - > - < ] > [ - < + > ] <
            
            /* If result == 0 ('['), increment nesting counter [4] */
            > [
                <<<<<<
                + 
                >>>>>>
            ]
            
            /* If result == 2 (']'), decrement nesting counter [4] */
            /* Re-match for 93 */
            [ - >+ < ] > [ - < + > ] <
            +++++ +++++ [ < ++++++++ > - ] < ++ +++++ +++++ +++++ +++
            < [ - > - < ] > [ - < + > ] <
            >
            [
                <<<<<<
                - 
                >>>>>>
            ]
            
            /* Return to loop check */
            <<<<<<<
            ++++ 
            [ - >>>>>>> <<<<<<< ]
            <<<
        ]
    ]
]

/* --- BACKWARD JUMP (]) ---
 * Opcode is ASCII 93. Match distance from 91 is 2.
 */

/* Check if Temp[4] was 2 */
[ - >+ < ] > [ - < + > ] <
> +++++ +++++ [ < ++++++++ > - ] < ++ +++++ +++++ +++++ +
< [ - > - < ] > [ - < + > ] <
>
[
    /* If result == 0, it was ']', but we need to see if GuestTape[VDP] != 0 */
    <<<<<<
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [ - >>>>>>> <<<<<<< ]
    
    /* Jump if non-zero */
    [
        /* Set Nesting Counter [4] = 1 */
        <<<<<<<
        >>>>>>>
        <<<<<<<
        +++ ++
        
        [ 
            /* Retreat IP [1] */
            <<<<<<<
            > -
            <<<<<<
            
            /* Fetch Token at GuestTape[7 + IP] */
            > [ - >+ >+ << ] >> [ - << + >> ] <<<
            >>>>>>>
            <<<<<<<
            [ - >>>>>>> <<<<<<< ]
            [ - >+ < ] >
            
            /* Check token: '[' (91) or ']' (93) */
            +++++ +++++ [ < ++++++++ > - ] < ++ +++++ +++++ +++++ +
            < [ - > - < ] > [ - < + > ] <
            >
            [
                /* If '[', decrement nesting counter */
                <<<<<<
                - 
                >>>>>>
            ]
            
            [ - >+ < ] > [ - < + > ] <
            +++++ +++++ [ < ++++++++ > - ] < ++ +++++ +++++ +++++ +++
            < [ - > - < ] > [ - < + > ] <
            >
            [
                /* If ']', increment nesting counter */
                <<<<<<
                + 
                >>>>>>
            ]
            
            <<<<<<<
            ++++ 
            [ - >>>>>>> <<<<<<< ]
            <<<
        ]
    ]
]
