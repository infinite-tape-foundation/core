# v3 Bracket Logic Implementation Detail

To complete the Self-Referential Loop in version 3, we must implement recursive control flow ('[' and ']'). This is the most complex part of the interpreter as it requires non-linear movement across the source code while maintaining a nesting count.

## The Forward Jump (`[`)
1. **Condition**: Triggered when opcode == '[' AND GuestTape[VDP] == 0.
2. **Action**: 
   - Set Nesting Counter [7] = 1.
   - Increment IP [1].
   - Read current token at GuestTape[8 + IP].
   - If token == '[', increment Nesting Counter [7].
   - If token == ']', decrement Nesting Counter [7].
   - Repeat until Nesting Counter [7] == 0.
   - The final position of IP is the matching bracket; execution continues from IP+1.

## The Backward Jump (`]`)
1. **Condition**: Triggered when opcode == ']' AND GuestTape[VDP] != 0.
2. **Action**:
   - Set Nesting Counter [7] = 1.
   - Decrement IP [1].
   - Read current token at GuestTape[8 + IP].
   - If token == ']', increment Nesting Counter [7].
   - If token == '[', decrement Nesting Counter [7].
   - Repeat until Nesting Counter [7] == 0.
   - Execution resumes from this matching '[' (which will be re-evaluated by the dispatcher).

## Memory Integration
The v3 memory map allocates cell [7] specifically for the Nesting Counter, ensuring it does not interfere with the VDP or mirrors during the scan process.
