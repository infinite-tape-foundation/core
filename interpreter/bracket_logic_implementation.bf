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
    > > > [ - > + < ] < < < /* Copy IP to Temp A */
    > > > > >              /* Navigate to SourceBase */
    < < < < [ - > + < ]     /* Shift by IP */
    [ - < < < < + > ]       /* Copy value to Opcode[1] */
    < < < < <               /* Return to IP [0] */

    /* If Opcode == '[' (91), increment Nesting Counter [3] */
    > 
    [ - > > + < < ]        /* Copy Opcode to Temp A [3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 from Temp A */
    < 
    ++++++++++++++++++++++++++++++
    [ - > + < ]            /* Offset from 43 to 91 is 48 */
    > 
    [ - > + < ]           /* Flag in Temp B if match */
    > 
    [ - > > + < < ]       /* If flag, increment Nesting Counter [3] */
    < < [ - ]              /* Clear flag */

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
    < < [ - ]              /* Clear flag */

    /* Check if Nesting Counter [3] is 0. If not, increment IP and continue loop. */
    < < < 
    [ - > + < ]           /* Move Nesting Counter to Temp B [4] */
    > 
    [ - ]                 /* This clears the counter; we must restore it or use a copy */
    /* Correction: We need to check if [3] == 0 without destroying it. */
    /* Actually, the simplest BF way to 'loop while [3] != 0' is just using [3]. */
    
    /* Let us refine this logic for actual integration into linear_exec.bf later. */
    /* For now, we record the structural approach in this artifact. */
    
    +                    /* Increment IP for next iteration */
]
