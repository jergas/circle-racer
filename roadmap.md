# Development Roadmap

## Phase 1: The Physics Prototype (Current Goal)
**Objective**: A playable loop on macOS with the "Passageway" map.

- [ ] **Project Setup**: Initialize Godot project, setup Git repository.
- [ ] **Player Mechanics**:
    - implement `RigidBody2D` character.
    - Implement "Bounce" physics material (friction 0, restitution 1).
    - Logic: Apply random impulse on start; handle collision direction changes.
- [ ] **The "Passageway" Map**:
    - Create a map scene with Wall boundaries (top/bottom).
    - Add "Geometric Shape" obstacles (Triangles/Rectangles) protruding from walls.
    - Set Spawn point (Left) and Goal point (Right/Star).
- [ ] **Game Loop**:
    - Detect Goal entry.
    - Show "Nice!" UI (Custom Label/Panel, not OS notification).
    - Restart mechanism.

## Phase 2: Core Gameplay Structure
**Objective**: Expand to a full game loop with multiple levels.

- [ ] **Game Manager**: Global singleton to manage level loading.
- [ ] **UI System**: Main Menu, Pause Menu, Victory Screen.
- [ ] **Asset Polish**: Better geometric sprites, particle effects for bounces/goal.

## Phase 3: The Map Editor
**Objective**: Allow dynamic creation of content.

- [ ] **Data Serialization**: Define a JSON schema for maps.
- [ ] **Runtime Editor**:
    - UI Panel to select Obstacles.
    - Mouse click to place/rotate objects.
    - "Play Test" button to switch to Game Mode immediately.
    - Save/Load functionality using `FileAccess`.

## Phase 4: Independent 3D Expansion
**Objective**: Build a standalone 3D version of the game that runs off the same map data.

- [ ] **Map Loader Adaptation**: Update Map Loader to support spawning `Node3D` equivalents (Meshes/PhysicsBodies) from the existing map data.
- [ ] **3D Physics Implementation**: Implement `RigidBody3D` player controller. Tune physics parameters to feel similar to the 2D version (or deliberately distinct).
- [ ] **3D Assets**: Create basic 3D primitives (Cubes, Spheres) to represent the 2D shapes.
- [ ] **Mode Selector**: Update Main Menu to choose between "Classic 2D" and "3D" modes.

## Phase 5: Linux Migration & Distribution
**Objective**: Shift development to Linux and setup distribution.

- [ ] **CI/CD**: Github Actions to build for Win/Mac/Linux automatically.
- [ ] **Linux Dev Environment**: Verify project works on Ubuntu/Fedora (Godot native).
- [ ] **Distribution**: Itch.io page or Steam setup.
