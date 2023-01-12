extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5

var follow_cam: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_follow_cam(follow_setting):
	follow_cam = follow_setting


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#broken, not today's issue
	if follow_cam:
		if direction:
			#transform.basis = transform.basis.rotated((0.0, 1.0, 0.0), 5.0))
			velocity.z = direction.z * SPEED
		else:
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	else:
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
			

func reset(last_exit):
	# 1 = up, 2 = right
	# 3 = down, 4 = left
	# we need to do the opposite because we are "entering"
	velocity = Vector3.ZERO
	
	if last_exit == 1:
		position = Vector3(0.0, 0.5, 4.0)
	elif last_exit == 2:
		position = Vector3(-4.0, 0.5, 0.0)
	elif last_exit == 3:
		position = Vector3(0.0, 0.5, -4.0)
	else:
		position = Vector3(4.0, 0.5, 0.0)
		
