extends Node3D

@onready var _player: CharacterBody3D = $"../player_main/player"


func _ready() -> void:
	pass


# this is kinda lame
func _process(delta: float) -> void:
	position = _player.position
	rotation = _player.rotation
