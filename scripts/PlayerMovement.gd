extends CharacterBody3D
class_name PlayerMovement

@onready var music_manager : MusicManager = %music_manager
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var character_model: Node3D = $"3DGodotRobot"
@onready var rythm_indicator_animation : AnimationPlayer = $"3DGodotRobot/rythm_indicator/AnimationPlayer"
@onready var main_camera : Node3D = %CameraPivot

var bpm_in_seconds : float
var current_status : PlayerStatus
var parameters : PlayerMovementParameters

@export_group("Grounded")
@export var grounded_movement_speed := 200.0
@export var coyote_time := 0.5
@export var jump_velocity := 7.00

@export_group("Airborne")
@export var airborne_movement_speed := 200.0
@export var extra_jumps := 1
@export var fall_velocity := 1.00

@export_group("Dashing")
@export var dash_speed := 400.0
@export var dash_duration := 1.5

@export_group("Debug")
var beat_count := 0
var off_beat_count := 0

func _ready() -> void:
	music_manager.beat.connect(_on_beat)
	music_manager.off_beat.connect(_off_beat)
	music_manager.track_changed.connect(_on_track_change)
	_on_track_change()
	parameters = PlayerMovementParameters.new(
		main_camera,
		grounded_movement_speed,
		coyote_time,
		jump_velocity,
		airborne_movement_speed,
		extra_jumps,
		dash_speed,
		dash_duration)
	change_status(PlayerStatusGrounded.new(self, parameters))

func _physics_process(delta: float) -> void:
	move_and_slide()
	if current_status:
		current_status.process_state(delta)

func change_status(new_status : PlayerStatus):
	if current_status:
		current_status.exit_state()
	current_status = new_status
	current_status.enter_state()

func _on_beat() -> void:
	beat_count += 1
	current_status.on_beat()

func _off_beat() -> void:
	off_beat_count += 1
	current_status.off_beat()

func _on_track_change():
	# TODO: Mover a su propia clase
	bpm_in_seconds = music_manager.beat_interval
	rythm_indicator_animation.speed_scale = (2 + music_manager.time_delay) / bpm_in_seconds
	rythm_indicator_animation.play("default")

func _input(event: InputEvent) -> void:
	current_status.process_input(event)
