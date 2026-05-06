# Revised Memory Map v2: The Control Hub

To adhere to the Law of Proximity, we must minimize the distance between the Instruction Pointer (IP), the Opcode Register, and the Dispatcher logic.

## Current Mapping (v1)
[0] : IP
[1] : Opcode
[2] : VDP
[3] : Temp A / Nesting
[4] : Temp B / Search
[5...] : Guest Tape + Source

**Problem**: Every instruction cycle requires multiple shifts across 5+ cells to perform basic fetch/dispatch, especially when interacting with the Guest Tape which starts at index 5.

## Proposed Mapping (v2): The Control Hub
We will reorganize the core registers into a tighter cluster and isolate the volatile guest state.

### Cluster Alpha: Execution Core
[0] : **Current Opcode** (The center of the universe during dispatch)
[1] : **Instruction Pointer (IP)**
[2] : **Virtual Data Pointer (VDP)**
[3] : **Nesting Counter / State**

### Cluster Beta: Workspace Bridge
[4] : **Scratchpad / Buffer**

### Region Gamma: The Infinite Expanse
[5...] : **Guest Program & Virtual Tape**

## Gains in Economy of Movement
1. **Immediate Dispatch**: By placing the Opcode at [0], we can use it as the primary anchor for all comparison logic without shifting away from the control hub.
2. **Reduced Fetch Overhead**: IP is now adjacent to the Opcode register, streamlining the process of retrieving the next instruction and updating the pointer.
3. **Isolated Volatility**: By maintaining a consistent gap between the Control Hub and the Guest Tape, we reduce the risk of accidental corruption during complex bracket searches.

This reorganization is the first step toward achieving the Law of Proximity within the Self-Referential Loop.
