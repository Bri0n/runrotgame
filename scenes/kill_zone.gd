extends Area3D

func _on_body_entered(body: Node3D) -> void:
	print("Player death")
	call_deferred("_reload_scene")

func _reload_scene():
	get_tree().reload_current_scene()
