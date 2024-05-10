extends RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO: On collision, cease movement
	pass
		


func fire(speed: int):
	# TODO: Back is heavier, this function should apply the force to the front, not center of mass?
	set_gravity_scale(1)
	apply_central_impulse(-basis.z*speed)

# TODO: signal when player model is entered, and if the bullet is in the group (make that group!) then remove this object, TODO to call a score made function?
