/* 
 * v3 Movement Cluster Implementation Snippet
 * Logic for '<' (60) and '>' (62)
 */

/* --- MOVEMENT ('<', '>') MATCH ---
 * Base = 60 ('<')
 */

[ - >+ < ] > [ - < + > ] < /* Copy Opcode [3] to Temp [4] */
> +++++ +++++ [ < ++++++++ > - ] < ++++ 
/* Subtract 60 from Temp[4] */
< [ - > - < ] > [ - < + > ] < 

>
[
    /* Result is in Temp [5]. If 0, it was '<'. If 2, it was '>'. */
    
    /* Case: '<' (Result == 0) */
    /* We must first handle the non-zero case to isolate zero */
    [ - >+ < ] > [ - < + > ] < /* Copy result back to check */
    
    /* If not zero, we go into the '>' logic; if zero, we do '<' */
    
    /* This section requires precise pointer movements. */
    /* To implement '<': Decrement VDP [2] */
    <<<<<<
    /* Move to VDP [2] */
    <<<<
    -
    >>>>
    <<<<<<
    /* Return and clear match flag */
    >>>
    [ - < + > ] < 
]
