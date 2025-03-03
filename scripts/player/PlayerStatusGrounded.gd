extends PlayerStatus

class_name PlayerStatusGrounded

const PlayerMovementCommands = preload("res://scripts/GlobalConstants.gd").PlayerMovementCommands
var _camera: Node3D
var _movement_speed : float
var _sprint_speed : float
var _movement_direction : Vector3 = Vector3.ZERO
var _player : PlayerMovement
var _parameters

var _jump_velocity : float
var _initial_velocity : Vector3

# Coyote time
var _coyote_time := 0.5
var _coyote_time_timer = -1

func _init(player : PlayerMovement, parameters : PlayerMovementParameters):
	_camera = parameters.camera
	_player = player
	_movement_speed = parameters.grounded_movement_speed
	_sprint_speed = parameters.sprint_movement_speed
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
	
	if input_direction: 
		_movement_direction = (camera_right * input_direction.x + camera_forward * input_direction.y).normalized()
		
	else:
		_movement_direction = Vector3.ZERO
		
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
		if Input.is_action_pressed("sprint"):
			_player.velocity.x += _movement_direction.x * _sprint_speed * delta
			_player.velocity.z += _movement_direction.z * _sprint_speed * delta
			_player.velocity.x = clamp(_player.velocity.x, -8, 8)
			_player.velocity.z = clamp(_player.velocity.z, -8, 8)
		else:
			print("dawd" + str(_movement_direction))
			var _velocity_x = _player.velocity.x + (_movement_direction.x * _movement_speed * delta)
			var _velocity_z = _player.velocity.z + (_movement_direction.z * _movement_speed * delta)
			print("Velocidad ground en var en x" + str(_velocity_x))
			print("Velocidad ground en var en z" + str(_velocity_z))	
			_player.velocity.x = clamp(_velocity_x, -5.0, 5.0)
			_player.velocity.z = clamp(_velocity_z, -5.0, 5.0)
			print("Velocidad clampeada en x" + str(_player.velocity.x))
			print("Velocidad clampeada en z" + str(_player.velocity.z))	
		
	
	else:
		_player.velocity.x = move_toward(_player.velocity.x, 0, _movement_speed * delta * 2)
		_player.velocity.z = move_toward(_player.velocity.z, 0, _movement_speed * delta * 2)
