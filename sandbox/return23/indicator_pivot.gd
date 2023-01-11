extends Node3D

var indicator

# Called when the node enters the scene tree for the first time.
func _ready():
	indicator = get_node("indicator")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#rotate_y(0.25 * delta);
	pass

func change_things(progress, exit):
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	# move the marker
	if exit == 1:
		position = Vector3(0.0, 1.5, 5.0)
	elif exit == 2:
		position = Vector3(-5.0, 1.5, 0.0)
	elif exit == 3:
		position = Vector3(0.0, 1.5, -5.0)
	else:
		position = Vector3(5.0, 1.5, 0.0)
	
	#update progress
	indicator.mesh.material.set_shader_parameter("progress", progress)
