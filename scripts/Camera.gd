extends Node3D

@export var initial_pitch : float = 0.0
@export var pitch_limit = deg_to_rad(80)
@export var mouse_sensitivity := 0.0025
@export var gamepad_sensitivity := 0.02

var mouse_captured : bool = true
var pitch: float = deg_to_rad(initial_pitch)

func _process(delta: float) -> void:
	self.rotation.x -= Input.get_axis("look_up", "look_down") * gamepad_sensitivity
	self.rotation.y += Input.get_axis("look_right", "look_left") * gamepad_sensitivity
	self.rotation.x = clampf(self.rotation.x, -pitch_limit, pitch_limit)

func _input(event: InputEvent) -> void:
	_handle_mouse_capture(event)
	_handle_camera_rotation(event)

func _handle_mouse_capture(event: InputEvent):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_captured = true
	elif Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_captured = false

func _handle_camera_rotation(event: InputEvent):
	var rotation_x : float = 0.0
	var rotation_y : float = 0.0
	if mouse_captured:
		if event is InputEventMouseMotion:
			self.rotation.x -= event.screen_relative.y * mouse_sensitivity
			self.rotation.y -= event.screen_relative.x * mouse_sensitivity
	self.rotation.x = clampf(self.rotation.x, -pitch_limit, pitch_limit)
