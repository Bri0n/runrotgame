extends Node

enum PlayerMovementCommands {
	NONE,
	JUMP,
}

const PLAYER_NAME := "player"
const EXIT_HALLWAY_NAME := "exit_transition_hallway"
const ENTRY_HALLWAY_NAME := "entry_transition_hallway"

var moving_transition_hallway : Node3D
var next_level_entry_hallway : Node3D
var next_level_exit_hallway : Node3D
