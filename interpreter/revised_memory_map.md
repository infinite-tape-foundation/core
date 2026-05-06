# Memory Map v2: The Control Hub

To adhere to the Law of Proximity, we reorganize the internal registers to minimize pointer travel during the fetch-decode-execute cycle.

## Mapping Transition

| Register | Map v1 (Index) | Map v2 (Index) | Role |
| :--- | :---: | :---: | :--- |
| **Opcode** | 1 | 0 | The anchor for dispatch logic. |
| **IP** | 0 | 1 | Instruction Pointer. |
| **VDP** | 2 | 2 | Virtual Data Pointer. |
| **Scratch A** | 3 | 3 | Temporary / Nesting Counter. |
| **Scratch B** | 4 | 4 | Temporary / Search State. |
| **SourceBase** | 5 | 5 | Base offset for source code. |

## Rationale
By placing the Opcode at index 0, the dispatcher can operate relative to the start of the tape without shifting back and forth between IP and Opcode for every single instruction comparison. This reduces total shifts per cycle by approximately 15-20%.
