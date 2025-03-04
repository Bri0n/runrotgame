extends Node3D

@onready var model_animation_player: AnimationPlayer = $chips/AnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var points_given : int = 0
@export var seconds_given : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	model_animation_player.play("idle")

func _on_body_entered(body: Node3D) -> void:
	animation_player.play("chip_pickup")
	GameManager.process_pickup(points_given, seconds_given)
