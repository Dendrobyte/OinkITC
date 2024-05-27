extends RigidBody3D

var firing_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(-basis.z*delta*firing_speed)
	if collision:
		# Spawn new static bolt?
		var dummy = collision.get_collider(0)
		if dummy.name == "DummyStaticBody3D":
			 # TODO: I don't like this, better to have an Area3D?
			dummy.is_hit()
			queue_free()

func fire(speed: int):
	# TODO: Back is heavier, this function should apply the force to the front, not center of mass?
	set_gravity_scale(1)
	firing_speed = speed
	$ArrowShootSound.play()

# TODO: signal when player model is entered, and if the bullet is in the group (make that group!) then remove this object, TODO to call a score made function?
