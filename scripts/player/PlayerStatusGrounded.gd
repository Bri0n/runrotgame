extends PlayerStatus

class_name PlayerStatusGrounded

const PlayerMovementCommands = preload("res://scripts/GlobalConstants.gd").PlayerMovementCommands
var _camera: Node3D
var _movement_speed : float
var _movement_direction : Vector3 = Vector3.ZERO
var _player : PlayerMovement
var _parameters

var _jump_velocity : float

# Coyote time
var _coyote_time := 0.5
var _coyote_time_timer = -1

func _init(player : PlayerMovement, parameters : PlayerMovementParameters):
	_camera = parameters.camera
	_player = player
	_movement_speed = parameters.grounded_movement_speed
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

func _handle_jump() -> void:
	if _coyote_time_timer > 0:
		_player.velocity.y = _jump_velocity
		_player.change_status(PlayerStatusAirborne.new(_player, _parameters))

func _move(delta : float) -> void:
	if _movement_direction:
		_player.velocity.x = _movement_direction.x * _movement_speed * delta
		_player.velocity.z = _movement_direction.z * _movement_speed * delta
		var horizontal_direction = Vector3(_movement_direction.x, 0, _movement_direction.z).normalized()
		var target_position = _player.global_transform.origin - horizontal_direction

	else:
		_player.velocity.x = move_toward(_player.velocity.x, 0, _movement_speed * delta)
		_player.velocity.z = move_toward(_player.velocity.z, 0, _movement_speed * delta)
