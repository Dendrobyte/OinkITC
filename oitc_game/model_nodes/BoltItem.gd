extends RigidBody3D

var fired: bool = false
var speed_change: int = 0
var start_origin: Vector3 # needed??

# Called when the node enters the scene tree for the first time.
func _ready():
	set_gravity_scale(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (fired):
		# apply physics until it collides with a player model
		print("Flying as fired!")
		var curr_motion = get_transform().origin
		#move_and_collide(Vector3(curr_motion.x*speed_change*delta, curr_motion.y*speed_change*delta, curr_motion.z*speed_change*delta))
		


func fire(speed: int):
	if (fired == true):
		queue_free() # Debugging step to remove it for now
		print("removed!")
	# TODO: Call parent "reload" functino where the check for more bolts will happen
	print("Fired from bolt item function!")
	set_gravity_scale(1)
	speed = speed
	fired = true

# TODO: signal when player model is entered, and if the bullet is in the group (make that group!) then remove this object, TODO to call a score made function?
