/*
 * Bracket Logic Implementation: Phase II of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] IP
 * [1] Opcode
 * [2] VDP
 * [3] Nesting Counter / Temp A
 * [4] Search State / Temp B
 * [5...] Guest Program (SourceBase = 5)
 */

/* --- FORWARD JUMP ([) ---
 * Triggered if Opcode == '[' and GuestTape[VDP] == 0
 */

/* Condition Check: Is GuestTape[VDP] == 0? 
 * We copy GuestTape[VDP] to Temp B [4]. If it is non-zero, we skip the jump logic.
 */
< < [ - > + < ] > > // Move VDP[2] to Temp B[4]
> > > 
< [ - > + < ] // Shift by VDP offset starting from SourceBase [5] into a temp cell
< < < < < // Return to IP [0]

/* The jump trigger depends on whether the cell at GuestTape[VDP] was zero. 
 * For this implementation snippet, we define the core search movement.
 */

/* Initialize Search: Set Nesting Counter [3] to 1 */
> > > + 

/* Advance IP [0] */
< < < + 

/* Search Loop: Continue until Nesting Counter [3] is 0 */
[ 
    /* Fetch current opcode at IP into Opcode Register [1] */
    > > > [ - > + < ] < < < // Copy IP[0] to Temp A[3]
    > > > > > // To SourceBase [5]
    < < < < [ - > + < ] // Shift right by Temp A [3]
    [ - < < < < + > ] // Copy result to Opcode[1]
    < < < < < // Return to IP [0]

    /* If opcode == '[' (91), increment Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ] // Subtract 80
    < 
    +++++++++++++++++++
    [ - > + < ] // Offset to reach 91
    > [ - ] < 
    < < 
    + 

    /* If opcode == ']' (93), decrement Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ]
    < 
    +++++++++++++++++++++
    [ - > + < ] // Offset to reach 93
    > [ - ] < 
    < < 
    - 

    /* Check if search is complete: is Nesting Counter [3] zero? */
    < < < 
    [ 
        /* Increment IP and repeat */
        < < < + 
        > > > 
    ] 
]

/* --- BACKWARD JUMP (]) ---
 * Triggered if Opcode == ']' and GuestTape[VDP] != 0
 */

/* Initialize Search: Set Nesting Counter [3] to 1 */
> > > + 

/* Retreat IP [0] */
< < < - 

/* Search Loop: Continue until Nesting Counter [3] is 0 */
[ 
    /* Fetch current opcode at IP into Opcode Register [1] */
    > > > [ - > + < ] < < < // Copy IP[0] to Temp A[3]
    > > > > > // To SourceBase [5]
    < < < < [ - > + < ] // Shift right by Temp A [3]
    [ - < < < < + > ] // Copy result to Opcode[1]
    < < < < < // Return to IP [0]

    /* If opcode == ']' (93), increment Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ] 
    < 
    +++++++++++++++++++++
    [ - > + < ] 
    > [ - ] < 
    < < 
    + 

    /* If opcode == '[' (91), decrement Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ]
    < 
    +++++++++++++++++++
    [ - > + < ] 
    > [ - ] < 
    < < 
    - 

    /* Check if search is complete: is Nesting Counter [3] zero? */
    < < < 
    [ 
        /* Decrement IP and repeat */
        < < < - 
        > > > 
    ] 
]
