extends Node3D

@onready var main_theme: AudioStreamPlayer = $MainTheme
@onready var footstep_1: AudioStreamPlayer = $Footstep1
@onready var doorslam: AudioStreamPlayer = $Doorslam


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_footstep_audio():
	#if not footstep_1.playing: ##Queda mejor solapado
	footstep_1.pitch_scale = randf_range(0.8, 1.2)
	footstep_1.play()
	
func play_doorslam_audio():
	doorslam.play()
