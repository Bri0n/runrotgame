extends PlayerStatus

class_name PlayerStatusGrounded

# @onready var audio_manager: Node3D = null LO PASÉ A SINGLETON (AUTOLOAD)

const PlayerMovementCommands = preload("res://scripts/GlobalConstants.gd").PlayerMovementCommands
var _camera: Node3D
var _movement_speed : float
var _stopping_speed : float = 25.0 # TODO: Pasarlo a parameters
var _sprint_speed : float
var _max_grounded_speed : float
var _max_sprint_speed : float
var _movement_direction : Vector3 = Vector3.ZERO
var _player : PlayerMovement
var _parameters

var _jump_velocity : float
var _initial_velocity : Vector3

# Coyote time
var _coyote_time := 0.5
var _coyote_time_timer = -1

# Sprint FOV lerp
var normal_fov: float = 75.0
var sprint_fov: float = 60.0
var fov_lerp_speed: float = 5.0  # Velocidad de interpolación del FOV
var is_moving: bool = false

# Headbob
var head_bob_intensity = 0.05
var head_bob_speed = 22.0
var head_bob_timer = 0.0

func _init(player : PlayerMovement, parameters : PlayerMovementParameters):
	_camera = parameters.camera
	_player = player
	_movement_speed = parameters.grounded_movement_speed
	_sprint_speed = parameters.sprint_movement_speed
	_max_grounded_speed = parameters.max_grounded_movement_speed
	_max_sprint_speed = parameters.max_sprinting_speed
	_coyote_time = parameters.coyote_time
	_jump_velocity = parameters.jump_velocity
	_parameters = parameters

func enter_state():
	print("Entered Grounded state.")
	

func exit_state():
	pass

func process_state(delta : float):
	if _player.is_on_floor():
		_coyote_time_timer = _coyote_time
	else:
		_coyote_time_timer -= delta
		if _coyote_time_timer <= 0:
			_player.change_status(PlayerStatusAirborne.new(_player, _parameters))
	_read_movement_input()
	_move(delta)
	_update_fov(delta)

func _read_movement_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	
	# Get the direction the camera is pointing to without a vertical component
	var camera_forward := _camera.transform.basis.z.normalized()
	camera_forward.y = 0
	camera_forward = camera_forward.normalized()
	var camera_right := _camera.transform.basis.x.normalized()
	camera_right.y = 0
	camera_right = camera_right.normalized()
	
	_movement_direction = (camera_right * input_direction.x + camera_forward * input_direction.y).normalized()

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_handle_jump()
	if event.is_action_pressed("noclip"):
		_player.change_status(PlayerStatusNoClip.new(_player, _parameters))

func _handle_jump() -> void:
	if _coyote_time_timer > 0:
		_player.velocity.y = _jump_velocity
		_player.change_status(PlayerStatusAirborne.new(_player, _parameters))

func _move(delta : float) -> void:
	if _movement_direction:
		is_moving = true
		var current_movement_speed : float
		var current_maximum_speed : float
		if Input.is_action_pressed("sprint"):
			current_movement_speed = _sprint_speed
			current_maximum_speed = _max_sprint_speed
			head_bob_timer += delta * head_bob_speed
			_camera.transform.origin.y = sin(head_bob_timer) * head_bob_intensity
		else:
			current_movement_speed = _movement_speed
			current_maximum_speed = _max_grounded_speed
			_camera.transform.origin.y = 0
		var velocity_change_x = _movement_direction.x * _movement_speed * delta
		var velocity_change_z = _movement_direction.z * _movement_speed * delta
		var max_velocity = _movement_direction * current_maximum_speed
		
		_player.velocity.x = clamp(_player.velocity.x + velocity_change_x, -max_velocity.x, max_velocity.x)
		_player.velocity.z = clamp(_player.velocity.z + velocity_change_z, -max_velocity.z, max_velocity.z)

	else:
		_player.velocity.x = move_toward(_player.velocity.x, 0, _stopping_speed * delta)
		_player.velocity.z = move_toward(_player.velocity.z, 0, _stopping_speed * delta)
		is_moving = false
	if _player.velocity.length() > 0:
		AudioManager.play_footstep_audio()

func _update_fov(delta: float):
	if is_moving:
		var target_fov = sprint_fov if Input.is_action_pressed("sprint") else normal_fov
		_camera.fov = lerp(_camera.fov, target_fov, fov_lerp_speed * delta)
