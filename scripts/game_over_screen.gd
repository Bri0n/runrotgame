extends Control

var elapsed_time : float
var remaining_time : float
var pickups_count : int
var final_score : int

# Labels
@onready var start_button: Button = $VBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var score_label: Label = $VBoxContainer2/HBoxContainer4/score_label
@onready var pickups_count_label: Label = $VBoxContainer2/HBoxContainer3/pickups_count_label
@onready var time_elapsed_label: Label = $VBoxContainer2/HBoxContainer/time_elapsed_label
@onready var time_left_label: Label = $VBoxContainer2/HBoxContainer2/time_left_label


# Values
@onready var time_elapsed_value: Label = $VBoxContainer2/HBoxContainer/time_elapsed_value
@onready var time_left_value: Label = $VBoxContainer2/HBoxContainer2/time_left_value
@onready var pickups_count_value: Label = $VBoxContainer2/HBoxContainer3/pickups_count_value
@onready var score_value: Label = $VBoxContainer2/HBoxContainer4/score_value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()
	_update_texts()
	elapsed_time = GameManager.elapsed_time
	remaining_time = GameManager.remanining_time
	pickups_count = GameManager.pickups_count
	final_score = GameManager.score
	time_elapsed_value.text = _make_times_pretty(elapsed_time)
	time_left_value.text = _make_times_pretty(remaining_time)
	pickups_count_value.text = str(pickups_count)
	score_value.text = _make_score_pretty(final_score)

func _make_times_pretty(seconds : float):
	var hours = int(seconds) / 3600
	seconds = seconds - hours * 3600
	var minutes = int(seconds) / 60
	seconds = seconds - (minutes * 60)
	return "%02d:%02d:%05.2f" % [hours, minutes, seconds]

func _make_score_pretty(score : int):
	var thousands = score / 1000
	var hundreds = score - (thousands * 1000)
	var pretty_score : String
	if thousands > 0:
		pretty_score = "%03d.%03d" % [thousands, hundreds]
	else:
		pretty_score = "%03d" % hundreds
	return pretty_score

func _on_start_button_pressed() -> void:
	GameManager.restart_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _update_texts():
	if GlobalConstants.game_language == GlobalConstants.GameLanguage.SPANISH:
		start_button.text = "Volver a empezar"
		quit_button.text = "Salir"
		score_label.text = "Puntaje final"
		pickups_count_label.text = "Papitas recolectadas"
		time_elapsed_label.text = "Tiempo de juego"
		time_left_label.text = "Tiempo restante"
	elif GlobalConstants.game_language == GlobalConstants.GameLanguage.ENGLISH:
		start_button.text = "Restart"
		quit_button.text = "Quit"
		score_label.text = "Final Score"
		pickups_count_label.text = "Pickup count"
		time_elapsed_label.text = "Time elapsed"
		time_left_label.text = "Time leftover"
