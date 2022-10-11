extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func receive_changes(color_array, wave_direction, ripple_seed, time_bias):
	mesh.material.set_shader_parameter("colors", color_array)
	mesh.material.set_shader_parameter("wave_direction", wave_direction)
	mesh.material.set_shader_parameter("ripple_seed", ripple_seed)
	mesh.material.set_shader_parameter("time_biase", time_bias)
