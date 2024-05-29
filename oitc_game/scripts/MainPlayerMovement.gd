extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const PLAYER_ID = 111 # obviously needs to become dynamic

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var max_speed = 8
var mouse_sensitivity = 0.002

@onready
var camera = $CameraPivot/PlayerView

func _ready():
	# THIS SHOULD NOT BE IN THE MAIN PLAYER MOVEMENT SCRIPT LMAO
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	# Handle camera/model movement
	# TODO: Use the basis for transforms as the mouse moves
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation.y += -event.relative.x * mouse_sensitivity
		rotation.x += clamp(-event.relative.y * mouse_sensitivity, -1.48, 1.48)
