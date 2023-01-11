extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	change_things(0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_things(progress):
	mesh.material.set_shader_parameter("progress", progress)
