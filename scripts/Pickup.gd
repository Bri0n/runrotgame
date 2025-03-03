extends Node3D

@onready var animation_player: AnimationPlayer = $chips/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")

func _on_body_entered(body: Node3D) -> void:
	queue_free()
