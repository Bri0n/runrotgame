extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var options_button: Button = $VBoxContainer/OptionsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	_update_texts()
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_language_toggle_toggled(toggled_on: bool) -> void:
	# on spanish, off english
	if toggled_on:
		GlobalConstants.game_language = GlobalConstants.GameLanguage.SPANISH
	else:
		GlobalConstants.game_language = GlobalConstants.GameLanguage.ENGLISH
	_update_texts()

func _update_texts():
	if GlobalConstants.game_language == GlobalConstants.GameLanguage.SPANISH:
		start_button.text = "Empezar"
		options_button.text = "Opciones"
		quit_button.text = "Salir"
	elif GlobalConstants.game_language == GlobalConstants.GameLanguage.ENGLISH:
		start_button.text = "Start"
		options_button.text = "Options"
		quit_button.text = "Exit"
