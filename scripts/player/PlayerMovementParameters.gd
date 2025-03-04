extends Node

class_name PlayerMovementParameters

# Camera
var camera: Node3D

# Grounded
var grounded_movement_speed : float
var sprint_movement_speed : float
var max_grounded_movement_speed : float
var max_sprinting_speed : float
var coyote_time : float
var jump_velocity : float

# Airborne
var fall_velocity : float
var airborne_movement_speed : float
var extra_jumps : int

# Dashing
var dash_speed : float
var dash_duration : float

func _init(
	camera : Node3D,
	grounded_movement_speed : float,
	sprint_movement_speed : float,
	max_grounded_movement_speed : float,
	max_sprinting_movement_speed : float,
	coyote_time : float,
	jump_velocity : float,
	fall_velocity : float,
	airborne_movement_speed : float,
	extra_jumps : int
	):
	self.camera = camera
	self.grounded_movement_speed = grounded_movement_speed
	self.sprint_movement_speed = sprint_movement_speed
	self.max_grounded_movement_speed = max_grounded_movement_speed
	self.max_sprinting_speed = max_sprinting_movement_speed
	self.coyote_time = coyote_time
	self.jump_velocity = jump_velocity
	self.fall_velocity = fall_velocity
	self.airborne_movement_speed = airborne_movement_speed
	self.extra_jumps = extra_jumps
