extends RigidBody3D

var vis_floor
var col_floor

var rng = RandomNumberGenerator.new()

var wave_direction: Vector2
var color_array: Array[Vector3] = [Vector3.ZERO, Vector3.ZERO]
var ripple_seed: float
var time_bias: float

var accumulator: float = 0.0
@export_range(0.1, 15.0) var refresh_rate

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	vis_floor = get_node("vis_floor")
	col_floor = get_node("col_floor")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	accumulator += delta
	if (accumulator > refresh_rate):
		change_things()
		accumulator = 0.0
	
func change_things():
	wave_direction = Vector2(rng.randf_range(0.1, 2.0), rng.randf_range(0.1, 2.0))
	color_array[0] = rand_color()
	color_array[1] = rand_color()
	#wave_time = Time.get_unix_time_from_system()
	ripple_seed = randf_range(0.1, 20.0)
	time_bias = 1.0 if randi() % 2 == 0 else -1.0
	
	vis_floor.receive_changes(color_array, wave_direction, ripple_seed, time_bias)
	col_floor.receive_changes(wave_direction)
	
func rand_color():
	return Vector3(rng.randf(), rng.randf(), rng.randf())
