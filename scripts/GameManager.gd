extends Node

var player: PlayerMovement
var current_level: Node
var next_level: Node

func load_next_scene(next_scene_pack : PackedScene, exit_position : Vector3):
	var next_level_scene = next_scene_pack.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	next_level.add_child(next_level_scene)
	
	var exit_transition_hallway : Node3D = current_level.get_child(0).get_node(GlobalConstants.EXIT_HALLWAY_NAME)
	var entry_transition_hallway : Node3D = next_level.get_child(0).get_node(GlobalConstants.ENTRY_HALLWAY_NAME)
	
	var relative_position = player.position - exit_transition_hallway.position
	var relative_rotation = player.camera.rotation - exit_transition_hallway.rotation
	player.position = entry_transition_hallway.position + relative_position
	player.camera.rotation = relative_rotation

func unload_previous_scene():
	current_level.get_child(0).queue_free()
	next_level.get_child(0).reparent(current_level)
