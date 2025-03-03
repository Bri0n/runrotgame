extends PlayerStatus

class_name PlayerStatusNoClip

const PlayerMovementCommands = preload("res://scripts/GlobalConstants.gd").PlayerMovementCommands
var _camera: Node3D
var _movement_speed : float
var _movement_direction : Vector3 = Vector3.ZERO
var _player : PlayerMovement
var _parameters

func _init(player : PlayerMovement, parameters : PlayerMovementParameters):
	_camera = parameters.camera
	_player = player
	_movement_speed = parameters.grounded_movement_speed
	_parameters = parameters

func enter_state():
	print("Entered No Clip state.")
	_player.velocity = Vector3.ZERO
	_player.player_collider.disabled = true

func exit_state():
	_player.player_collider.disabled = false

func process_state(delta : float):
	_read_movement_input()
	_move(delta)

func _read_movement_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	_movement_direction = (_camera.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

func process_input(event: InputEvent) -> void:
	if event.is_action_pressed("noclip"):
		_player.change_status(PlayerStatusGrounded.new(_player, _parameters))

func _move(delta : float) -> void:
	if _movement_direction:
		_player.velocity = _movement_direction * _movement_speed * delta

	else:
		_player.velocity = Vector3.ZERO
