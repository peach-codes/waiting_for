extends Node3D

func _init(seed):
	position = Vector3(seed, 0.2, 0.0)

func random_spawn():
	position = Vector3(randf(), 0.2, randf())
	
func move(to):
	position = to
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	# we're going from an i in a for loop, so 0 - 3
func change_things(exit_info):
	position = Vector3(0.0, 0.2, 0.0)
	if !exit_info.is_empty():
		if 0 in exit_info:
			position += Vector3(0.0, 0.0, -3.0)
		elif 1 in exit_info:
			position += Vector3(3.0, 0.0, 0.0)
		elif 2 in exit_info:
			position += Vector3(0.0, 0.0, 3.0)
		elif 3 in exit_info:
			position += Vector3(-3.0, 0.0, 0.0)
	position += Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))

# Called when the node enters the scene tree for the first time.
func _ready():
	random_spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
