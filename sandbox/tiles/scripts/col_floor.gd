extends CollisionShape3D
var heightmap
var heightmap_array
var accumulator = 0.0
var wave_direction = Vector2(1.0, 4.0)
var wave_time: float

const SIZE = 30
const H_RESOLUTION = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	heightmap = HeightMapShape3D.new()
	heightmap.set_map_depth(SIZE * H_RESOLUTION)
	heightmap.set_map_width(SIZE * H_RESOLUTION)
	heightmap_array = PackedFloat32Array()
	heightmap_array.resize(SIZE * SIZE * H_RESOLUTION * H_RESOLUTION)
	heightmap_array.fill(0.0)
	heightmap.set_map_data(heightmap_array)
	set_shape(heightmap) # this works!
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	accumulator += delta
	if(accumulator > 0.2):
		#heightmap_array = my_wave(Time.get_unix_time_from_system(), heightmap_array)
		#heightmap.set_map_data(heightmap_array)
		heightmap.set_map_data(my_wave(Time.get_unix_time_from_system(), heightmap_array))
		set_shape(heightmap)
		accumulator = 0.0
	
func my_wave(time, data):
	for i in data.size():
		var offset = 0
		# goes goes by row of x, -x to +x
		# bottom left, then up, then right
		var x_int: int = i % (H_RESOLUTION * SIZE) # within row
		var z_int: int = floor(i / (H_RESOLUTION * SIZE)) # which row?
		var x_pos: float = x_int / (H_RESOLUTION) - (SIZE / 2.0)
		var z_pos: float = z_int / (H_RESOLUTION) - (SIZE / 2.0)
		var wave_pos: float = (wave_direction.x * x_pos) + (wave_direction.y * z_pos) 
		# we have to account for how the height map is scaled down
		data[i] =  0.5 * H_RESOLUTION * cos( ((2.0 * time) + wave_pos + offset) / (2 * PI) )
	return data
		# shader equation
		#0.5 * cos( (2.0 * TIME + wave_pos) / (2.0 * PI));

func receive_changes(in_wave_direction):
	wave_direction = in_wave_direction
	#wave_time = in_wave_time
