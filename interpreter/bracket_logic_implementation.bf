/*
 * Implementation of Bracket Logic for the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] IP
 * [1] Opcode
 * [2] VDP
 * [3] Nesting Counter / Temp A
 * [4] Search State / Temp B
 * [5...] Guest Program (SourceBase = 5)
 */

/* 
 * FORWARD JUMP LOGIC ([) 
 * ASCII: 91
 * Triggered when Opcode == 91 AND GuestTape[VDP] == 0
 */

/* Condition Check: If GuestTape[VDP] != 0, skip jump logic */
< < [ - > + < ] /* Move VDP to NC [3] */
> > > > > 
< [ - > + < ] /* Shift to SourceBase+VDP and move value to Opcode Reg [1] temporarily? No, use Temp B [4] */
/* Better: Navigate from SourceBase using VDP into a temp cell and check if zero */

/* Actual implementation logic starts here */

/* Initialize Search: Set NC [3] = 1 */
> > [ - ] + 

/* Advance IP [0]++ */
< < < + 

/* SEARCH LOOP: While NC [3] != 0 */
> > [ 
    /* Fetch(IP [0]) -> Opcode [1] */
    < < < [ - > + < ] /* Copy IP to Temp A [3] (Wait, we need NC in [3]. Use [4]) */
    /* This is where the complexity of BF-in-BF resides. We must be extremely careful with scratchpads. */
    
    /* Step 1: Move current IP[0] to source code offset */
    < < < < < 
    /* ... fetch logic ... */
    
    /* If Opcode == '[' NC++ */
    /* If Opcode == ']' NC-- */
    
    /* Increment/Decrement IP [0] based on search direction */
    < < < + 
    
    > > /* Return to NC check */
] 

/* 
 * BACKWARD JUMP LOGIC (]) 
 * ASCII: 93
 * Triggered when Opcode == 93 AND GuestTape[VDP] != 0
 */

/* Initialize Search: Set NC [3] = 1 */
> > [ - ] + 

/* Retreat IP [0]-- */
< < < - 

/* SEARCH LOOP: While NC [3] != 0 */
> > [ 
    /* ... backward fetch and match logic ... */
    
    < < < - 
    
    > > /* Return to NC check */
]
