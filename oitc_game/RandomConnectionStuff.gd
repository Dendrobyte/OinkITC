extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var server_host = "127.0.0.1"
var server_port = 6767
var tcp_peer
var json = JSON.new()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: Likely change to ENetMultiplayerPeer for UDP?
	tcp_peer = StreamPeerTCP.new()
	tcp_peer.set_no_delay(true)
	var connRes = tcp_peer.connect_to_host(server_host, server_port)
	print("Connection result: ", connRes)


var connected = false
var sent_name = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while !connected:
		if tcp_peer.get_status() == 1:
			# If it's still connecting, re-poll
			tcp_peer.poll()
		if tcp_peer.get_status() == 2:
			print("Connection succeeded!")
			connected = true
		if tcp_peer.get_status() == 3:
			print("Connection errored!")
			connected = true

	# Just doing this once to test
	if !sent_name:
		var user = {"username": "Mark"}
		var send_name = JSON.stringify(user)
		print("Attempting to send:", send_name)
		tcp_peer.put_data(send_name)
		sent_name = true

	if !sent_name:
		pass  # Poll for a received input from the client
