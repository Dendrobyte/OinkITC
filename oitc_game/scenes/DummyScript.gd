extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func is_hit():
	$SoundPlayer.play()
	var newStaticBolt = load("res://assets/StaticBolt.glb").instantiate()
	add_child(newStaticBolt)
	newStaticBolt.set_global_position(global_position)
	newStaticBolt.global_basis = global_basis
	newStaticBolt.scale = Vector3(0.64, 0.64, 0.64) # cri

	# TODO (start here!) send signal to server
