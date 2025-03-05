extends RayCast3D

@onready var beam_mesh = $BeamMesh
@onready var end_particles: GPUParticles3D = $EndParticles
@onready var beam_particles: GPUParticles3D = $BeamParticles

@onready var player = get_tree().current_scene.get_node("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cast_point
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		var collider = get_collider()
		
		if collider == player:
			print("Raycast golpeó al player!")
			call_deferred("_game_over")
		
		beam_mesh.mesh.height = cast_point.y
		beam_mesh.position.y = cast_point.y/2
		
		end_particles.position.y = cast_point.y
		
		beam_particles.position.y = cast_point.y/2
		
		var particle_amount = snapped(abs(cast_point.y) * 50,1)
		
		if particle_amount > 1:
			beam_particles.amount = particle_amount
		else:
			beam_particles.amount = 1 
		
		beam_particles.process_material.set_emission_box_extents(
			Vector3(beam_mesh.mesh.top_radius, abs(cast_point.y)/2, beam_mesh.mesh.top_radius))
		
func _game_over():
	GameManager.end_game()
		
