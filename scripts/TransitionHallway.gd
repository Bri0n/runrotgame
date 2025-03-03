extends Node3D

@export var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not next_scene:
		push_error("Next scene is undefined!")


func _on_scene_load_triggered(body: Node3D) -> void:
	if body.name == GlobalConstants.PLAYER_NAME and next_scene:
		print(next_scene.resource_path)
		GameManager.load_next_scene(next_scene, position)


func _on_scene_switch_trigger(body: Node3D) -> void:
	if body.name == GlobalConstants.PLAYER_NAME:
		GameManager.unload_previous_scene()
