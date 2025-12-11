# Architectural Blueprint: Circle Racer (Working Title)

## 1. Technology Stack Selection

To meet the requirements of **Mac/Win/Linux support**, **Open Source stack**, and **2D-to-3D transition**, we propose the following stack:

*   **Game Engine**: **Godot Engine 4.x**
    *   **Why**:
        *   **Open Source**: MIT Licensed, fully free.
        *   **Cross-Platform**: Runs natively on macOS (Silicon), Windows, and Linux. Exports to all three.
        *   **2D & 3D**: First-class support for both. 2D is pixel-perfect; 3D is robust.
        *   **Linux First**: Godot developers heavily prioritize Linux support.
*   **Programming Language**: **GDScript**
    *   **Why**: Deeply integrated into Godot, Python-like syntax, rapid prototyping. Migration to C# (.NET 6) is possible later if performance is critical, but GDScript is sufficient for this game type.
*   **Version Control**: **Git**

## 2. System Architecture

### 2.1 Core Components (Godot Nodes)

The game will be structured as a collection of Scenes (`.tscn`).

*   **`Main.tscn`**: The entry point. Manages the high-level application state (Main Menu -> Game -> Pause).
*   **`Game.tscn`**: Instantiates the current Level and the Player.
*   **`Player.tscn`**:
    *   **Type**: `RigidBody2D` (Physics-based movement).
    *   **Sprite**: Texture for the Orange Circle.
    *   **CollisionShape2D**: Circle shape.
    *   **Script**: Handles bounce impulse randomization logic.
*   **`Level_X.tscn`**:
    *   **Type**: `Node2D`.
    *   **Structure**:
        *   `Geometry`: `StaticBody2D` nodes defining walls and obstacles.
        *   `SpawnPoint`: `Marker2D` indicating player start.
        *   `Goal`: `Area2D` with a Star sprite and collision shape.

### 2.2 Data Flow & Signals

We will use Godot's **Signal** system for decoupled communication.

1.  **Player** hits **Obstacle**:
    *   Physics engine handles collision response (bounce) automatically.
    *   Script detects collision to trigger "change random direction" logic if needed (or we verify if physics usage is sufficient).
2.  **Player** enters **Goal (Area2D)**:
    *   `Goal` emits `player_reached_goal`.
    *   `Game` manager catches signal -> Spawns "Nice!" UI popup.
    *   `Game` manager loads next level.

### 2.3 Map Editor Architecture

*   **Data Format**: JSON or Custom Resource (`.tres`).
    *   Stores list of obstacles (type, position, rotation, scale).
    *   Stores Spawn and Goal positions.
*   **Editor Implementation**:
    *   Can be built *inside* the game using Godot's UI nodes (`Control`, `GraphEdit` or just mouse placement).
    *   Or implemented as a bespoke `EditorPlugin` in Godot if the editor is for developers only.
    *   **Recommendation**: In-game runtime editor for user flexibility.

## 3. Independent 2D & 3D Implementations

The game will feature two distinct modes that share the same **content** but use different **engine implementations**.

*   **Shared Assets**:
    *   **Map Data**: A unified JSON/Resource format describing level layout (walls, obstacles, spawn, goal).
    *   **Game Rules**: The rules (bounce behavior, win condition) remain abstract and identical.
*   **Divergent Execution**:
    *   **2D Mode**: Uses `Node2D`, `Sprite2D`, and **`RigidBody2D`**.
    *   **3D Mode**: Uses `Node3D`, `MeshInstance3D`, and **`RigidBody3D`**.
*   **Map Loader Strategy**:
    *   The `MapLoader` class will have two methods: `build_2d(data)` and `build_3d(data)`.
    *   This allows the exact same level file to be played in either 2D or 3D, interpreting the data into the appropriate engine nodes.
*   **3D Implementation Plan**:
    *   We will not purely "project" 2D into 3D. instead, we will implement a full 3D physics simulation.
    *   We will constrain the 3D physics (e.g., lock Z axis) to mimic the 2D gameplay feel, or allow it to evolve into fully 3D gameplay as desired.

## 4. Development Environment (macOS -> Linux)

1.  **Current (macOS)**:
    *   Install Godot 4.x (Apple Silicon build).
    *   Git.
2.  **Future (Linux)**:
    *   Godot runs as a standalone binary or via Flatpak.
    *   Project files are identical.
    *   Build exports for Windows/Mac can be done FROM Linux.

