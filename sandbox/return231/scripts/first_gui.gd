extends Control

@onready var _progress_bar : ProgressBar = $my_Bar
@onready var _dist_bar : ProgressBar = $dist_bar
@onready var _mesg0 : Label = $my_thing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_progress_bar.ratio = 0.0
	_mesg0.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_progress_bar.ratio += delta / 15.0
	_progress_bar.ratio += -1.0 if _progress_bar.ratio > 0.999 else 0.0
	if _progress_bar.ratio > 0.80:
		_mesg0.show()
	else:
		_mesg0.hide()
	
func update_dist(dist: float, total: float) -> void:
	if dist <= total:
		_dist_bar.ratio = (dist/total)
	else:
		_dist_bar.ratio = 1.0
		_mesg0.show()
