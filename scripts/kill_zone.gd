extends Area3D

func _on_body_entered(body: Node3D) -> void:
	print("Player death")
	call_deferred("_game_over")

func _game_over():
	GameManager.end_game()
