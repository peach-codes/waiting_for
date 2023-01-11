extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
	# we need to do the opposite
	
	velocity = Vector3.ZERO
	
	if last_exit == 1:
		position = Vector3(0.0, 0.5, -4.0)
	elif last_exit == 2:
		position = Vector3(4.0, 0.5, 0.0)
	elif last_exit == 3:
		position = Vector3(0.0, 0.5, 4.0)
	else:
		position = Vector3(-4.0, 0.5, 0.0)
		
