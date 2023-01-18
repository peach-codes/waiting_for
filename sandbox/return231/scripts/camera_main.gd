extends Node3D

@onready var _player: CharacterBody3D = $"../player_main/player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = _player.position
	rotation = _player.rotation
