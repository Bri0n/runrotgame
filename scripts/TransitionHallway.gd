extends Node3D

@export var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not next_scene:
		push_error("Next scene is undefined!")


func _on_scene_load_triggered(body: Node3D) -> void:
	if body.name == GlobalConstants.PLAYER_NAME and next_scene:
		GameManager.load_next_scene(next_scene)
