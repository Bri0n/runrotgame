extends Node3D
@onready var made_in_48_hours: Label3D = $made_in_48_hours
@onready var controls_1: Label3D = $controls_1
@onready var controls_2: Label3D = $controls_2
@onready var title: Label3D = $title
@onready var chips: Label3D = $chips

func _ready() -> void:
	if GlobalConstants.game_language == GlobalConstants.GameLanguage.SPANISH:
		made_in_48_hours.text = "Un juego hecho\nen 48 horas para\naprender Godot"
		controls_1.text = "WASD para moverte,\nespacio para saltar"
		controls_2.text = "espacio en el aire para doble salto,\nshift para correr rápido"
		title.text = "runrot"
		chips.text = "Recolectar papitas\npara puntos\ny tiempo extra"
	elif GlobalConstants.game_language == GlobalConstants.GameLanguage.ENGLISH:
		made_in_48_hours.text = "A game built in\n48 hours to learn\nGodot"
		controls_1.text = "WASD to move,\nspacebar to jump"
		controls_2.text = "spacebar while airborne to\ndouble jump, shift to sprint"
		title.text = "runrot"
		chips.text = "Collect chips\nfor points\nand extra time"
