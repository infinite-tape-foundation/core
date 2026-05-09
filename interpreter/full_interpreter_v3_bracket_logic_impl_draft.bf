/*
 * Bracket Logic Implementation Draft for v3 Interpreter
 * 
 * Trigger: Range Filter identifies ASCII 91 ([) or 93 (])
 * Base: 91
 */

/* Copy Opcode [3] to Temp [4] and subtract 91 */
[ - >+ < ] > [ - < + > ] <
> +++++ +++++ [ < ++++++++ > - ] < ++++ ++++ +++
< [ - > - < ] > [ - < + > ] <

/* Match result is now in Temp [4]. 
   0 -> [
   2 -> ]
*/

/* --- Forward Jump ([) ---
   Condition: Result == 0 AND GuestTape[VDP] == 0
*/
>
[
    /* Check if GuestTape[VDP] == 0 */
    <<<<<<
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<< 
    [ - >>>>>>> <<<<<<< ]
    /* If it was non-zero, we do NOT jump. We must clear the match flag. */
    [ - > + < ] > 
    
    /* Now, if still in this block, GuestTape[VDP] was 0. Perform scan forward. */
    <<<<<<
    /* Set Nesting Counter Cell [4] = 1 (using a temporary cell for the scan loop) */
    >> ++
    
    /* Advance IP [1] */
    < +
    
    /* Scan Loop */
    [ 
        /* Fetch Token from GuestTape[7 + IP] */
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<< 
        [ - >>>>>>> <<<<<<< ]
        
        /* Compare token with '[' (91) and ']' (93) */
        /* ... logic to increment/decrement nesting counter ... */
        
        /* If counter == 0, terminate scan. */
    ]
]
