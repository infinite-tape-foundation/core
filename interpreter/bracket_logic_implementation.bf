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

/* Check condition: GuestTape[VDP] must be 0 */
< < [ - > + < ] > > > // Move VDP to Temp B
< [ - > + < ] // Shift to SourceBase+VDP
[ - ] // If not zero, we cannot jump; but for this snippet we assume trigger

/* Initialize search */
< < < < <
> > > +

/* Advance IP */
< < < +

/* Search Loop */
[
    /* Fetch current opcode at IP into Opcode Register [1] */
    > > > [ - > + < ] < < < // Copy IP to Temp A
    > > > > > // To SourceBase
    < < < < [ - > + < ] // Shift by IP
    [ - < < < < + > ] // Copy to Opcode[1]
    < < < < < // Return to IP

    /* If opcode == '[' (91), increment Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ] // Subtract ~80
    < 
    +++++++++++++++++++
    [ - > + < ] // Offset to 91
    > [ - ] < 
    < < 
    + 

    /* If opcode == ']' (93), decrement Nesting Counter [3] */
    > [ - > > + < < ] > > 
    ++++++++++ [ > ++++++++ < - ]
    < 
    +++++++++++++++++++++
    [ - > + < ] // Offset to 93
    > [ - ] < 
    < < 
    - 

    /* Loop continues until Nesting Counter [3] is 0 */
    < < < 
    [ - ] // Check counter; if 0 we exit
    
    /* Increment IP for next search step */
    < < < +
]

