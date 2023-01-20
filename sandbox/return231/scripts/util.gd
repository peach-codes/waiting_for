extends Object

# basic script for preserving some repeated functions
# working on silos, intentional structure for future

var rng : RandomNumberGenerator

func _init() -> void:
	# not _ready()
	# this current works, but there's probably a better way
	rng = RandomNumberGenerator.new()
	rng.randomize()

static func rand_npoint(n: int, scale: float, neg: bool) -> Array[float]:
	# returns n rand points between 0-1 if scale = 1.0 and neg = false
	var retval = [n]
	var bias = [n]
	if neg:
		for i in n:
			bias.append(-1.0 if randi() % 2 == 0 else 1.0)
	for i in n:
		retval.append(randf() * scale * bias[i])
	return retval

func ndist(p_0, p_1, n):
	for i in range(n):
		print(p_0[i])
