extends Node

var player: PlayerMovement
var current_level: Node
var next_level: Node
var current_level_path : String = "res://scenes/main.tscn"
var next_level_path : String
var levels := []

func _ready() -> void:
	load_levels("res://scenes/levels/")
	select_next_level()

func load_levels(folder_path: String):
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.ends_with(".tscn"):
					var file_path = folder_path + file_name
					levels.append(file_path)
			file_name = dir.get_next()
	print("Loaded levels: ", levels)

func load_next_scene():
	print("Loading scene: " + next_level_path)
	var next_level_scene : PackedScene = load(next_level_path)
	var next_level_instance = next_level_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	next_level.add_child(next_level_instance)

	var exit_transition_hallway : Node3D = current_level.get_child(0).get_node(GlobalConstants.EXIT_HALLWAY_NAME)
	var entry_transition_hallway : Node3D = next_level.get_child(0).get_node(GlobalConstants.ENTRY_HALLWAY_NAME)
	
	var relative_position = player.position - exit_transition_hallway.position
	var relative_rotation = player.camera.rotation - exit_transition_hallway.rotation
	player.position = entry_transition_hallway.position + relative_position
	player.camera.rotation = entry_transition_hallway.rotation + relative_rotation
	unload_previous_scene()

func unload_previous_scene():
	current_level.get_child(0).queue_free()
	next_level.get_child(0).reparent(current_level)
	current_level_path = next_level_path
	select_next_level()

func select_next_level():
	var random_index = randi() % levels.size()
	next_level_path = levels[random_index]
	while next_level_path == current_level_path:
		random_index = randi() % levels.size()
		next_level_path = levels[random_index]
	print("Next level selected: " + next_level_path)
