extends Area3D

@onready var animation_player: AnimationPlayer = $door_brown_a/AnimationPlayer
@onready var door_closed_collider: CollisionShape3D = $door_closed_collider
@onready var door_opened_collider: CollisionShape3D = $door_opened_collider

var is_open := false
var player_on_interaction_range := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_toggle_colliders()

func _on_body_entered(body: Node3D) -> void:
	player_on_interaction_range = body.name == GlobalConstants.PLAYER_NAME

func _on_body_exited(body: Node3D) -> void:
	player_on_interaction_range = !(body.name == GlobalConstants.PLAYER_NAME)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_on_interaction_range:
		if is_open:
			animation_player.play("door_close")
			is_open = false
			_toggle_colliders()
			
		else:
			animation_player.play("door_open")
			is_open = true
			_toggle_colliders()
		
		AudioManager.play_doorslam_audio()

func _toggle_colliders():
	door_opened_collider.disabled = !is_open
	door_closed_collider.disabled = is_open
