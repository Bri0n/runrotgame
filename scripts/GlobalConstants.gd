extends Node

enum PlayerMovementCommands {
	NONE,
	JUMP,
	SPRINT,
}

const PLAYER_NAME := "player"

# Level transition
const EXIT_HALLWAY_NAME := "exit_transition_hallway"
const ENTRY_HALLWAY_NAME := "entry_transition_hallway"

# Game start
const MAIN_SCENE_PATH := "res://scenes/main.tscn"
const LEVELS_FOLDER_PATH := "res://scenes/levels/"
const PLAYER_NODE_PATH := "/root/game/" + PLAYER_NAME
const CURRENT_LEVEL_NODE_PATH := "/root/game/current_level"
const NEXT_LEVEL_NODE_PATH :="/root/game/next_level"
const MAIN_MENU_NODE_PATH := "/root/MainMenu"
const MAIN_SCENE_NODE_PATH := "/root/game"

# Game over
const GAME_OVER_SCENE_PATH := "res://scenes/game_over.tscn"
const GAME_OVER_NODE_PATH := "/root/GameOver"
