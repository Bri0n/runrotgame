extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == GlobalConstants.PLAYER_NAME:
		call_deferred("_game_over")

func _game_over():
	GameManager.end_game()
