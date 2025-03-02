extends CharacterBody3D
class_name PlayerMovement

@onready var camera : Camera3D = $first_person_camera

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

func _ready() -> void:
	parameters = PlayerMovementParameters.new(
		camera,
		grounded_movement_speed,
		coyote_time,
		jump_velocity,
		fall_velocity,
		airborne_movement_speed,
		extra_jumps)
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

func _input(event: InputEvent) -> void:
	current_status.process_input(event)
