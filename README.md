# Baggage Conveyor Belt System

A professional baggage conveyor belt system designed for Roblox, featuring server-authoritative spawning, smooth movement, and interactive synchronized visuals.

## Features

### Synchronized Spawning and Movement
Bags are spawned at an origin point at the start of the conveyor. The system uses a centralized heartbeat loop on the server to ensure all bags move forward at a consistent speed, keeping all clients in perfect synchronization.

### Configurable Spawn Intervals
The time between bag spawns is controllable via a dedicated user interface.
- Default interval is set to 1.0 seconds.
- Adjustable between 0.1 and 10.0 seconds.
- The control UI is assigned to the first player who joins the server to maintain authority and prevent conflicts.

### Visual and Interactive Elements
- Initial Animation: Bags feature an entry animation upon spawning.
- Deletion Animation: Once the bag reaches the end of the 100-stud conveyor, it undergoes a spin and shrink animation before being removed from the workspace.
- Randomization: Every bag is assigned a random material and color upon creation.
- Interaction: Clicking a bag will output the part's unique ID to both the client and server logs.

## Technical Architecture

The project follows a modular structure to ensure maintainability and performance:
- Server Logic: Authoritative management of spawning, movement, and interaction handling.
- Client Logic: Localized UI management and interaction detection.
- Shared Modules: Central distribution of constants, visual configurations, and factory patterns.

## Performance and Stability
The system includes a safeguard that limits the maximum number of active bags to 500. This ensures server stability even when spawn intervals are set to the minimum value for extended periods.

## Setup Instructions

To build the project from source, use the following commands:

```bash
rojo build -o "Baggage-Conveyor-Belt.rbxlx"
```

Start the Rojo server to sync changes to Roblox Studio:

```bash
rojo serve
```