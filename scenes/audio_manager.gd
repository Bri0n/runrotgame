extends Node3D

@onready var main_theme: AudioStreamPlayer = $MainTheme
@onready var footstep_1: AudioStreamPlayer3D = $Footstep1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_footstep_audio():
	footstep_1.pitch_scale = randf_range(0.8, 1.2)
	footstep_1.play()
