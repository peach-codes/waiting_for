extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROT_0 = 1.0 * PI / 2.0
const FACE_BACK = PI

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func nrr(in_rad):
	# normalize rad rot
	var int_rots = int(in_rad / (2 * PI))
	var retval = in_rad - (int_rots * 2 * PI)
	return retval


func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# rotate player around own axis
	if Input.is_action_pressed("ui_left"):
		rotate_y( 0.02 )
	elif Input.is_action_pressed("ui_right"):
		rotate_y( - 0.02 )
		
	# translation did not work...
	# going with velocity for now
	var tmp = rotation.y
	if Input.is_action_pressed("ui_up"):
		velocity = ( Vector3(-sin(tmp), 0.0, -cos(tmp))) * SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity = ( Vector3(-sin(tmp), 0.0, -cos(tmp))) * -1.0 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	#print(rotation.y, " : (", -sin(rotation.y), ", ", -cos(rotation.y))
	#print(position)
	transform = transform.orthonormalized()
	move_and_slide()
