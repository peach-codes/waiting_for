extends Node3D

@onready var _gui : Control = $gui0 #update_dist(x,1)
@onready var _player: CharacterBody3D = $player_main/player
@onready var _floor_vis : MeshInstance3D = $envr_main/floor/floor_vis
@onready var _util_script : Object = load("res://scripts/util.gd")

const SCALE = 30.0 #sorta random

var sample_points
var util

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	util = _util_script.new()
	_floor_vis.mesh.material.set_shader_parameter("points", util.rand_npoint(10, SCALE, true))
	#print(util.ndist(0.0, 1.0, 1))
	print(util.ndist([0.0, 0.0], [1.0, 1.0], 2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
