extends Node

@onready var flower_shader = preload("res://shaders/flower.gdshader")

var petals = []

func add_petal(rotation_val):
	
	var my_mesh = MeshInstance3D.new()
	
	var my_plane = PlaneMesh.new()
	my_plane.material = ShaderMaterial.new()
	my_plane.material.shader = flower_shader
	
	my_mesh.mesh = my_plane
	my_mesh.position = Vector3(0.0, 1.0, 0.0)
	return my_mesh

func hello():
	add_petal(0.0)
	print("petal added")
	
	var mesh = add_petal(0.0)
	mesh.owner = self
	add_child(mesh)
	
func _init():
	print("flower script here now?")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("flower script here")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# not in use, working it out
func generate(num_petals):
	var tmp
	for i in num_petals:
		tmp = add_petal(0.0)
		add_child(tmp)
		petals.append(tmp)
