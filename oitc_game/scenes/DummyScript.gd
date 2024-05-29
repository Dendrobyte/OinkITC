extends StaticBody3D

signal dummy_is_hit(s_id: int, v_id: int)

const d_id = 122

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func is_hit(p_id: int):
	$SoundPlayer.play()
	var newStaticBolt = load("res://assets/StaticBolt.glb").instantiate()
	add_child(newStaticBolt)
	newStaticBolt.set_global_position(global_position)
	newStaticBolt.global_basis = global_basis
	newStaticBolt.scale = Vector3(0.64, 0.64, 0.64) # cri

	# NOTE: Ideally this gets moved into a util function or something?
	dummy_is_hit.emit(p_id, d_id)
	die()

func die():
	# "Kills" the dummy
	# TODO: Pick a random location and respawn a dummy
	# TODO: Drop bacon
	queue_free()