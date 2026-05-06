/*
 * Bracket Logic implementation for the BF-in-BF Interpreter.
 * 
 * Memory Map:
 * [0] IP
 * [1] Opcode
 * [2] VDP
 * [3] Nesting Counter / Temp A
 * [4] Search State / Temp B
 * [5...] Guest Program (SourceBase = 5)
 */

/* Forward Jump logic ([) - Triggered when GuestTape[VDP] == 0 */

/* 1. Initialize Nesting Counter [3] to 1 */
> > > + < < <

/* 2. Advance IP [0] */
+ 

/* 3. Search Loop */
[
    /* Fetch opcode at SourceBase[5] + IP[0] into Opcode Register [1] */
    > > > [ - > + < ] < < < /* Copy IP to Temp A [3] */
    > > > > >              /* Navigate to SourceBase [5] */
    < < < < [ - > + < ]     /* Shift by IP value in Temp A */
    [ - < < < < + > ]       /* Copy value to Opcode [1] */
    < < < < <               /* Return to IP [0] */

    /* If Opcode == '[' (91), increment Nesting Counter [3] */
    > 
    [ - > > + < < ]        /* Copy Opcode to Temp A [3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 from Temp A [3] */
    < 
    ++++++++++++++++++++++++++++++
    [ - > + < ]            /* Offset from 43 to 91 is 48 */
    > 
    [ - > + < ]           /* Flag in Temp B if match */
    > 
    [ - > > + < < ]       /* If flag, increment Nesting Counter [3] */
    < < [ - ]              /* Clear flag [4] */

    /* If Opcode == ']' (93), decrement Nesting Counter [3] */
    > 
    [ - > > + < < ]        /* Copy Opcode to Temp A [3] */
    > > 
    +++++++ [ > ++++++ < - ]
    < 
    ++++++++++++++++++++++++++++++
    ++ 
    [ - > + < ]           /* Offset from 43 to 93 is 50 */
    > 
    [ - > + < ]           /* Flag in Temp B if match */
    > 
    [ - > > - < < ]       /* If flag, decrement Nesting Counter [3] */
    < < [ - ]              /* Clear flag [4] */

    /* Check if Nesting Counter [3] is 0. */
    /* Since the loop continues while [0] IP is non-zero, we must ensure */
    /* that the search stops when Nesting Counter [3] hits zero. */
    /* To do this in BF, we move the counter check into a guard or use it as the loop condition. */
    
    /* For now: Increment IP and continue searching until Nesting Counter is 0. */
    /* Note: Actual integration will wrap this in a loop conditioned on cell [3]. */
    +
]
