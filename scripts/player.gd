extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera_joint = $CameraJoint
var power = 1.0
func cool(delta):
	# Heat loss due to convection:
	# q = hcW A dT
	#   q = heat transferred per unit time (Watts aka Joules / sec)
	#   A = heat transfer area of the surface (m^2)
	#   hcW = heat transfer coefficient (Watts / (m^2 deg C))
	#   dT = temperature difference between surface and "bulk fluid" (deg C)
	# Free convection heat transfer coefficient for air, gases: 0.5 - 100 (W/m^2K) 
	# Ooh can be based on velocity:
	# hcW = 12.12 - 1.16 v + 11.6 v1/2 
	# where hcW is heat transfer coefficient
	# and v is velocity between object surface and air (m/s)
	
	pass

func _process(_delta):
	camera_joint.set_position(get_position())

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("player_left", "player_right", "player_forward", "player_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		direction = direction.rotated(Vector3.UP, camera_joint.rotation.y)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
