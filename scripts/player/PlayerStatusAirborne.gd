extends PlayerStatus

class_name PlayerStatusAirborne

const PlayerMovementCommands = preload("res://scripts/GlobalConstants.gd").PlayerMovementCommands

# Basic
var _camera: Node3D
var _player : PlayerMovement
var _parameters : PlayerMovementParameters

# Movement
var _movement_speed : float
var _movement_direction : Vector3 = Vector3.ZERO

# Jump
var _jump_velocity : float
var _fall_velocity : float

# Double jump
var _extra_jumps : int

func _init(
	player : PlayerMovement,
	parameters : PlayerMovementParameters,
	extra_jumps : int = -1):
	
	# Basic
	_camera = parameters.camera
	_player = player
	_parameters = parameters
	
	# Movement
	_movement_speed = parameters.airborne_movement_speed
	
	# Jump
	_jump_velocity = parameters.jump_velocity
	_fall_velocity = parameters.fall_velocity
	
	# Double jump
	if extra_jumps >= 0:
		_extra_jumps = extra_jumps
	else:
		_extra_jumps = parameters.extra_jumps
	

func enter_state():
	print("Entered Airborne State.")
	# If the player enters the state by walking off a ledge,
	# it enters the state without vertical velocity

func exit_state():
	pass

func process_state(delta : float):
	if _player.is_on_floor():
		_player.change_status(PlayerStatusGrounded.new(_player, _parameters))
	else:
		_player.velocity += _player.get_gravity() * _fall_velocity * delta
		_read_movement_input()
		_move(delta)

func process_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		_double_jump()
	if event.is_action_pressed("noclip"):
		_player.change_status(PlayerStatusNoClip.new(_player, _parameters))

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

func _move(delta : float) -> void:
	if _movement_direction:
		_player.velocity.x = _movement_direction.x * _movement_speed * delta
		_player.velocity.z = _movement_direction.z * _movement_speed * delta
		var horizontal_direction = Vector3(_movement_direction.x, 0, _movement_direction.z).normalized()
		var target_position = _player.global_transform.origin - horizontal_direction

	else:
		_player.velocity.x = move_toward(_player.velocity.x, 0, _movement_speed * delta)
		_player.velocity.z = move_toward(_player.velocity.z, 0, _movement_speed * delta)

func _double_jump():
	if _extra_jumps > 0:
		_extra_jumps -= 1
		_player.velocity.y = _jump_velocity
