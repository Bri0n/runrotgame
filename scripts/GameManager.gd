extends Node

var player: PlayerMovement

# Scene management
var current_level_node : Node
var next_level_node : Node

# Level change
var levels : PackedStringArray
var current_level_name : String
var next_level_name : String
var next_level_scene : PackedScene

# Scene Management
var main_scene

# Timer
var counting_down : bool = false
var remanining_time : float = 300.0
var elapsed_time : float = 0.0

# Pickups
var pickups_count : int = 0
var score : int = 0

func _ready() -> void:
	levels = ResourceLoader.list_directory(GlobalConstants.LEVELS_FOLDER_PATH)
	select_next_level()

func _process(delta: float) -> void:
	if counting_down:
		remanining_time -= delta
		elapsed_time += delta

# Game start and end

func start_game(escena_que_borrar : String = "_delete_main_menu"):
	_instatiate_main_scene()
	_set_node_variables()
	_set_gameplay_variables()
	call_deferred(escena_que_borrar)

func _instatiate_main_scene():
	var main_scene_instance = load(GlobalConstants.MAIN_SCENE_PATH).instantiate()
	get_tree().root.add_child(main_scene_instance)

func _set_node_variables():
	current_level_node = get_node(GlobalConstants.CURRENT_LEVEL_NODE_PATH)
	next_level_node = get_node(GlobalConstants.NEXT_LEVEL_NODE_PATH)
	player = get_node(GlobalConstants.PLAYER_NODE_PATH)

func _set_gameplay_variables():
	counting_down = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _delete_main_menu():
	get_node(GlobalConstants.MAIN_MENU_NODE_PATH).free()
	get_tree().current_scene = get_node(GlobalConstants.MAIN_SCENE_NODE_PATH)

func restart_game():
	start_game("_delete_game_over_screen")

func _delete_game_over_screen():
	get_node(GlobalConstants.GAME_OVER_NODE_PATH).free()
	get_tree().current_scene = get_node(GlobalConstants.MAIN_SCENE_NODE_PATH)

func increase_remaining_time(increment_in_seconds : float):
	remanining_time += increment_in_seconds

func _on_timer_timeout():
	end_game()

func end_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file(GlobalConstants.GAME_OVER_SCENE_PATH)

func process_pickup(points : int = 0, seconds : float = 0):
	pickups_count += 1
	score += points
	increase_remaining_time(seconds)

func load_next_scene():
	var path_to_next_level = GlobalConstants.LEVELS_FOLDER_PATH + next_level_name
	var next_level_instance = load(path_to_next_level).instantiate()
	next_level_node.add_child(next_level_instance)
	call_deferred("_complete_transition")

func _complete_transition():
	var exit_transition_hallway : Node3D = current_level_node.get_child(0).get_node(GlobalConstants.EXIT_HALLWAY_NAME)
	var entry_transition_hallway : Node3D = next_level_node.get_child(0).get_node(GlobalConstants.ENTRY_HALLWAY_NAME)
	
	var relative_position = player.position - exit_transition_hallway.position
	var relative_rotation = player.camera.rotation - exit_transition_hallway.rotation
	player.position = entry_transition_hallway.position + relative_position
	player.camera.rotation = entry_transition_hallway.rotation + relative_rotation
	unload_previous_scene()

func unload_previous_scene():
	current_level_node.get_child(0).queue_free()
	next_level_node.get_child(0).reparent(current_level_node)
	current_level_name = next_level_name
	select_next_level()

func select_next_level():
	var random_index : int = randi() % levels.size()
	next_level_name = levels[random_index]
	while next_level_name == current_level_name:
		random_index = randi() % levels.size()
		next_level_name = levels[random_index]
	print("Next level selected: " + next_level_name)
