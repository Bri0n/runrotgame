extends Control
@onready var loading_text: Label = $loading_text

func _ready() -> void:
	if GlobalConstants.game_language == GlobalConstants.GameLanguage.SPANISH:
		loading_text.text = "Cargando..."
	elif GlobalConstants.game_language == GlobalConstants.GameLanguage.ENGLISH:
		loading_text.text = "Loading..."
