/* 
 * v3 Movement Cluster Implementation - Finalized
 * Logic for '<' (60) and '>' (62)
 */

/* --- MOVEMENT ('<', '>') MATCH ---
 * Base = 60 ('<')
 */

[ - >+ < ] > [ - < + > ] < /* Copy Opcode [3] to Temp [4] */
> +++++ +++++ [ < ++++++++ > - ] < ++++ 
/* Subtract 60 from Temp[4] */
< [ - > - < ] > [ - < + > ] < 

/* Now Temp [4] contains: 0 if '<', 2 if '>' */

/* First, we isolate the '>' case by copying the result and testing it */
[ - >+ < ] > [ - < + > ] <
>
[
    /* If non-zero, it must be '>'. Execute Guest Move Right. */
    <<<<<
    +
    >>>>>
    
    /* Clear current match flag cell to prevent double execution */
    [ - < + > ] <
]

/* Now we handle '<'. We check the original subtraction result again. */
/* Since we are in the Movement Cluster, if it wasn't '>', it MUST be '<'. */
/* To do this safely, we check if our previous '>' block didn't execute. */

/* Logic: Use a temporary flag for '<' */
<<<<
/* Back to Opcode [3], copy to Temp [4] again */
[ - >+ < ] > [ - < + > ] <
> +++++ +++++ [ < ++++++++ > - ] < ++++ 
< [ - > - < ] > [ - < + > ] < 

/* Result is in Temp [4]. If 0, it's '<'. */
/* In BF, we simulate 'if zero' by using a temporary cell. */
>
[
    /* This is non-zero (it was '>'). Do nothing here. */
    - 
]
<
[
    /* This executes ONLY if Temp[4] was 0 ('<') */
    <<<<<
    -
    >>>>>
    
    /* Clear match flags */
    >>> [ - < + > ] <
]
