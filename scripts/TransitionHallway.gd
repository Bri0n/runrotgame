extends Node3D

func _on_scene_load_triggered(body: Node3D) -> void:
	if body.name == GlobalConstants.PLAYER_NAME:
		GameManager.load_next_scene()
