# Technical Memo: Baggage Conveyor Belt Implementation

This document outlines the technical approach, design rationale, and optimizations implemented for the WKEY Studios take-home assignment.

## Approach and Architecture

The system is built using a **server-authoritative model** with a modular structure. All critical state (bag generation, movement, and interval management) is handled on the server to prevent client-side discrepancies and ensure synchronization across all players.

### 1. Movement System: CFrame vs. Physics
One of the primary design choices was using **CFrame-based movement** in a `RunService.Heartbeat` loop rather than a physics-based conveyor (e.g., using `Velocity` or `BasePart.AssemblyLinearVelocity`). 

**Why CFrame?**
- **Performance**: Manually updating CFrames is significantly cheaper than the physics engine calculating collisions and friction for dozens of dynamic objects.
- **Reliability**: Physics-based conveyors in Roblox can occasionally cause "shuddering" or bags glitching into the belt. CFrame movement is pixel-perfect and frame-rate independent.

### 2. Spawning System
The `SpawnerService` manages the creation of bags using a `BagFactory` module. 
- **Guidance-based IDs**: Every bag is assigned a unique GUID. This ID is used for interaction logging.
- **Resource Management**: I implemented a hard limit of 500 bags. If the server reaches this limit, it skips spawns until the conveyor clears. This protects the server from potential "interval spam" if a developer sets the spawn rate to 0.1s for a long duration.

### 3. Visual Synchronization
To ensure every player sees the same material and color, the randomization logic is executed on the server inside the `BagFactory`. These properties are then replicated naturally via the Roblox property system. 

### 4. Interactive Click Handling
The requirement for both client and server prints on click was handled by using a `ClickDetector` on the server and a local listener on the client:
- The **Server** prints the log to confirm ownership and authoritative detection.
- The **Client** prints a local log for immediate feedback.

---

## Scrapped Ideas and Iteration

### Scrapped: Direct MeshPart Deployment
Initially, I attempted to use `MeshParts` with a pre-configured asset. However, syncing external MeshPart assets through Rojo can sometimes lead to delay issues or "infinite yields" if the asset isn't immediately available in the local Studio instance.
- **Pivot**: I switched to a `Part` with an internal `SpecialMesh`. This is much more robust for Rojo projects as it allows the `MeshId` to be set dynamically at runtime.

### Iteration: Visual Fallback
During testing, some meshes failed to render immediately.
- **Solution**: I implemented a "Walled Cube" fallback. The bag is a solid part with the suitcase mesh welded to it. This ensures that even if a MeshId fails to load from the Roblox website, the colorful "bag" is still visible to the player, maintaining gameplay integrity.

### Scrapped: Tween-based Movement
I considered using `TweenService` for the conveyor movement, but for continuous linear motion across a long distance for many objects, a `Heartbeat` loop is more performant and easier to interrupt for despawning.

---

## Conclusion
The final result is a performant, synchronized system that meets all criteria.
