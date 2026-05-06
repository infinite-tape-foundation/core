/*
 * Bracket Logic Implementation: Phase II of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode Register
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Nesting Counter / Temp A
 * [4] : Search State / Temp B
 * [5...] : Guest Program and Workspace (SourceBase = 5)
 */

/* 
 * FORWARD JUMP ([ where GuestTape[VDP] == 0) 
 * logic starts here
 */

/* Step 1: Check if value at GuestTape[VDP] is zero */
< < 
[ - > + < ] /* Move VDP[2] into Temp A [3] */
> > 
> > > 
< [ - > + < ] /* Shift by VDP offset from SourceBase [5], move target to Temp B [4] */

/* If Target != 0, we skip jump and continue linear execution */
> 
[ - < + > ] /* Move target back to a flag cell */
< 
[ - ] /* Clear the cell for potential search use */

/* If it was 0, we proceed with search. Since BF doesn't have 'if-not', 
   this section of code would be wrapped in the dispatcher's equality check.
 */

/* Initialize Nesting Counter [3] = 1 */
< < 
+ 

/* Advance IP [0] */
< < < 
+ 

/* Search Loop */
[ 
    /* Fetch current opcode into Register [1] */
    > > > 
    [ - > + < ] /* Copy IP [0] to Temp A [3] */
    > > > > > 
    < < < < [ - > + < ] 
    [ - < < < < + > ] /* Opcode to Register [1] */
    < < < < < 

    /* If opcode == '[' (91), increment Nesting Counter [3] */
    > 
    [ - > > + < < ] /* Opcode to Temp A [3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Sub 43 */
    < 
    ++++++++++++++++++++++++++++++ 
    [ - > + < ] /* Offset from 43 to 91 is 48 */
    > 
    [ - < + > ] /* If match, add to Nesting Counter [3] */
    < 
    [ - ] 

    /* If opcode == ']' (93), decrement Nesting Counter [3] */
    > 
    [ - > > + < < ] 
    > > 
    +++++++ [ > ++++++ < - ] 
    < 
    ++++++++++++++++++++++++++++++
    ++ 
    [ - > + < ] /* Offset from 43 to 93 is 50 */
    > 
    [ - < - > ] /* If match, subtract from Nesting Counter [3] */
    < 
    [ - ] 

    /* Check if Nesting Counter [3] is 0 */
    < < 
    [ - > + < ] /* Move NC[3] to Temp B [4] */
    > 
    [ - < + > ] /* If not zero, set flag to continue loop */
    < 
    [ - ] 

    /* Advance IP [0] if not finished */
    < < < 
    + 
]
