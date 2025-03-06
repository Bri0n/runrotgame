extends Control

func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()

func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
