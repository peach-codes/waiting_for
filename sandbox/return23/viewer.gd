extends Node3D

var vis_floor
var character
var indicator_pivot
var congrats

var rng = RandomNumberGenerator.new()

var progress: float
var incr: float
var current_exit: int

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	vis_floor = get_node("stand_in_floor/basic_floor/vis_floor")
	character = get_node("character")
	indicator_pivot = get_node("indicator_pivot")
	congrats = get_node("messages")
	
	current_exit = (randi() % 4) + 1
	progress = 0.0
	incr = 0.1
	
	indicator_pivot.change_things(0.0, current_exit)
	congrats.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func change_things(last_exit):
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	# pass info along to shaders
	# reset player
	if progress >= 1.0:
		congrats.show()
	
	
	if (last_exit == current_exit) && (progress < 1.0):
		progress += incr
	
	# start of new cycle
	current_exit = (randi() % 4) + 1
	
	vis_floor.change_things(progress)
	indicator_pivot.change_things(progress, current_exit)
	character.reset(last_exit)


func _on_exit_up_entered(area):
	change_things(1)


func _on_exit_down_entered(area):
	change_things(3)


func _on_exit_left_entered(area):
	change_things(4)


func _on_exit_right_entered(area):
	change_things(2)
