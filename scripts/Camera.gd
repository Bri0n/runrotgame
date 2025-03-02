extends Node3D

@export var initial_pitch : float = 0.0
@export var pitch_limit = deg_to_rad(80)
@export var mouse_sensitivity := 0.005
@export var gamepad_sensitivity := 0.02

var mouse_captured : bool = false
var pitch: float = deg_to_rad(initial_pitch)

func _process(delta: float) -> void:
	self.rotation.x -= Input.get_axis("look_up", "look_down") * gamepad_sensitivity
	self.rotation.y += Input.get_axis("look_right", "look_left") * gamepad_sensitivity
	self.rotation.x = clampf(self.rotation.x, -pitch_limit, pitch_limit)

func _unhandled_input(event: InputEvent) -> void:
	_handle_mouse_capture()
	if mouse_captured and event is InputEventMouseMotion:
		self.rotation.x -= event.relative.y * mouse_sensitivity
		self.rotation.y += -event.relative.x * mouse_sensitivity
	self.rotation.x = clampf(self.rotation.x, -pitch_limit, pitch_limit)

func _handle_mouse_capture():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_captured = true
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_captured = false
