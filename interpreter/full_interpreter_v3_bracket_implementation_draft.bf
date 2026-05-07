/* 
 * DRAFT: Recursive Control Flow Integration for v3 Interpreter
 * This snippet is intended to be inserted into the dispatcher before IP increment.
 */

/* --- BRACKET ('[') MATCH ---
 * '[' is ASCII 91. Base = 43 (Arithmetic cluster). Offset = 48.
 */
[ - >+ < ] > [ - < + > ] <
> +++++ +++++ [ < ++++++++ > - ] < +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++
< [ - > - < ] > [ - < + > ] <
>
[
    /* EXECUTE FORWARD JUMP logic */
    <<<<<<
    /* Check GuestTape[VDP] */
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [ - >>>>>>> <<<<<<< ]
    
    /* If GuestTape[VDP] == 0, we jump */
    [ 
        /* This block executes if GuestTape[VDP] != 0; simply return and let IP increment normally */
        /* We must clear match flag to exit jump logic */
        <<<<<<<
        >>>
        [ - < + > ] <
        >>>>>>
        [ - < + > ] <
        <<<<<<
        - 
    ]
    
    /* If we reached here, GuestTape[VDP] == 0. Initiate Forward Scan. */
    <<<<<<
    /* Set Bracket Counter [4] = 1 */
    > + 
    
    /* Scan Loop */
    [ 
        /* Increment IP [1] */
        < + >
        
        /* Fetch current token at IP into Temp [4] (destructive fetch for scan) */
        /* Copy IP to mirror [5] */
        [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        
        /* Check if token is '[' (91) or ']' (93) */
        /* Temporary copy of token to check against 91/93 */
        [ - >+ < ] > 
        
        /* Test for '[' (91) */
        /* Offset from 43 is 48 */
        +++++ +++++ [ < ++++++++ > - ] < ++++ 
        < [ - > - < ] > 
        [
            /* It's a '[': increment counter */
            <<<<<<
            > + 
            <<<<<<
            >>>
            [ - < + > ] <
        ]
        
        /* Restore and test for ']' (93) */
        /* Offset from 43 is 50 */
        +++++ +++++ [ < ++++++++ > - ] < +++
        /* Actually we need the original value. Let's refine this logic in final integration. */
        
        /* For now, simplified scan marker */
        <<<<<<
        >>>
        [ - < + > ] <
    ]
    
    /* Return to Hub */
    <<<<<<<
    ++++ 
    [ - >>>>>>> <<<<<<< ]
    <<< 
    >>>
    [ - < + > ] <
]
