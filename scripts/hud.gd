extends Control

@onready var remaining_time: Label = $remaining_time
@onready var points_value: Label = $points_value

func _ready() -> void:
	remaining_time.text = _make_times_pretty(GameManager.remanining_time)
	points_value.text = _make_score_pretty(GameManager.score)

func _process(delta: float) -> void:
	remaining_time.text = _make_times_pretty(GameManager.remanining_time)
	points_value.text = _make_score_pretty(GameManager.score)
	
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
