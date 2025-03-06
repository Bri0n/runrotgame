extends Node3D

@onready var player: PlayerMovement = $player
@onready var current_level: Node = $current_level
@onready var next_level: Node = $next_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	'''
	GameManager.player = player
	GameManager.current_level = current_level
	GameManager.next_level = next_level
	'''
