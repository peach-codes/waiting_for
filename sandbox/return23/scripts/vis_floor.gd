extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	change_things(0.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_things(exit_progress, start_progress):
	mesh.material.set_shader_parameter("exit_progress", exit_progress)
	mesh.material.set_shader_parameter("start_progress", start_progress)

func set_colors(color_in):
	mesh.material.set_shader_parameter("color_in", color_in)
