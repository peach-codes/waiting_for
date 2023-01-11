extends Node3D

var vis_floor
var character
var indicator_pivot
var congrats
var flower_pivot
var camera_pivot

const INCR = 0.1
const DIMENSION = 20.0
const DIM_INT = 20
const follow_cam = false

var rng = RandomNumberGenerator.new()

var map_array = []
var color_array = []
var start: int
var exit: int
var exit_progress: float
var exit_progress_delta: float
var initial_exit_dist: float
var start_progress: float
var start_progress_delta: float
var incr: float
var current_exit: int
var player_pos = []
var start_pos = []
var exit_pos

func rand_color():
	return Vector3(rng.randf(), rng.randf(), rng.randf())
	
func dist(a,b):
	return sqrt((b[0] - a[0])**2 + (b[1] - a[1])**2)
	
func find_exits(pos_0, pos_1):
	# checks the 4 bordering points, then takes straight line distance to the exit point
	# returns an array with the straight line distance from the _next_ point to the exit as the first element
	# and a list of points that share that min distance
	var dists = []
	var current_min
	var retval = []
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	dists.append( dist( [int((pos_0[0] - 1 + DIM_INT)) % DIM_INT, pos_0[1]], pos_1) )
	dists.append( dist( [pos_0[0], (pos_0[1] + 1) % DIM_INT], pos_1) )
	dists.append( dist( [int((pos_0[0] + 1)) % DIM_INT, pos_0[1]], pos_1) )
	dists.append( dist( [pos_0[0], (pos_0[1] - 1 + DIM_INT) % DIM_INT], pos_1) )
	
	current_min = dists[0]
	for i in range(4):
		if dists[i] < current_min:
			current_min = dists[i]
	retval.push_back(current_min)
	for i in range(4):
		if dists[i] == current_min:
			retval.push_back(i)
	
	return retval
	
func map_update():
	
	var exit_info = []
	var start_info = []
	
	# find distances from the nearest 4 squares to the start and finish
	exit_info = find_exits(player_pos, exit_pos)
	start_info = find_exits(player_pos, start_pos)
	
	print("player: ", player_pos)
	print("exit: ", exit_pos, " - start: ", start_pos)
	print("distance and exits: ", exit_info)
	
	exit_progress = 1.0 - (abs(exit_info.pop_front() - 1.0) / (initial_exit_dist))
	start_progress = start_info.pop_front() - 1.0
	# send "hint" info to indicators
	indicator_pivot.change_things(start_progress, start_info.pick_random())
	flower_pivot.change_things(exit_info)
	# update floor color
	vis_floor.change_things(exit_progress, start_progress)
	

func map_initialize(mode):
	
	exit_progress = 0.0
	exit_progress_delta = 0.0
	start_progress = 1.0
	start_progress_delta = 0.0
	
	# starting logic for random exit + constant progress mode
	current_exit = (randi() % 4) + 1
	incr = INCR
	
	# starting logic for random start/end in square grid
	map_array.resize(DIMENSION * DIMENSION)
	map_array.fill(0.0)
	start = rng.randi_range(0, DIMENSION * DIMENSION - 1.0)
	exit = rng.randi_range(0, DIMENSION * DIMENSION - 1.0)
	while exit == start:
		push_warning("hey now\n")
		exit = rng.randi_range(0, DIMENSION * DIMENSION - 1.0)
	
	color_array = [rand_color(), rand_color()]
	vis_floor.set_colors(color_array)
	# (row, column), row-major
	# 00 01 02   0 1 2
	# 10 11 12   3 4 5
	# 20 21 22   6 7 8
	start_pos = [floor(start / DIMENSION), (start % int(DIMENSION))]
	exit_pos = [floor(exit / DIMENSION), (exit % int(DIMENSION))]
	
	player_pos = [start_pos[0], start_pos[1]]
	initial_exit_dist = dist(start_pos, exit_pos)
	
	print(start, " ", start_pos)
	print(exit, " ", exit_pos)
	print(initial_exit_dist)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	vis_floor = get_node("stand_in_floor/basic_floor/vis_floor")
	character = get_node("character")
	character.set_follow_cam(follow_cam)
	indicator_pivot = get_node("indicator_pivot")
	congrats = get_node("messages")
	congrats.hide() #this should really go to messages or congrats
	flower_pivot = get_node("structures/flower_pivot")
	camera_pivot = get_node("CameraPivot")
	
	
	map_initialize("grid")
	#map_initialize("random")
	map_update()
	
	
	indicator_pivot.change_things(0.0, current_exit)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow_cam:
		camera_pivot.position = character.position + Vector3(0.0, 1.0, 0.8)
		camera_pivot.rotation.x = PI/3.0
	
	
func change_things(last_exit):
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	# pass info along to shaders
	# reset player
	
	# show success
	# this sucks and is excessive
	if (int(player_pos[0]) == int(exit_pos[0])) && ( int(player_pos[1]) == int(exit_pos[1]) ):
		congrats.show()
	
	# start of new cycle
	map_update()
	character.reset(last_exit)


func _on_exit_up_entered(area):
	player_pos[0] = int(player_pos[0] - 1 + DIM_INT) % DIM_INT
	change_things(1)


func _on_exit_down_entered(area):
	player_pos[0] = int(player_pos[0] + 1) % DIM_INT
	change_things(3)


func _on_exit_left_entered(area):
	player_pos[1] = int(player_pos[1] - 1 + DIM_INT) % DIM_INT
	change_things(4)


func _on_exit_right_entered(area):
	player_pos[1] = int(player_pos[1] + 1) % DIM_INT
	change_things(2)
