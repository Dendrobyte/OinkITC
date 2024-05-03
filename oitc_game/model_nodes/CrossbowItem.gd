extends Node3D

"""
This will handle all the crossbow functionality, starting with just shooting the bolt.

The bolt count, when implemented, should be on the PLAYER movement script! This way we only have to go one level up/down for bolt/count respectively.
For now, just one until it's shot.
"""

@export_range(1, 200)
var bolt_speed: int = 1 # TODO: move this?
var originBoltPosition: Vector3
var originBoltRotation: Vector3
var staticBolt
var hasStaticBolt: bool
# TODO: hold on to start position, etc. here instead of in _process

# Called when the node enters the scene tree for the first time.
func _ready():
	staticBolt = $StaticBolt # The one initially in the scene tree
	update_origin_position_rotation($StaticBolt.global_position, $StaticBolt.global_rotation)
	hasStaticBolt = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Always update the currBolt position for spawning a new one
	if hasStaticBolt: update_origin_position_rotation(staticBolt.global_position, staticBolt.global_rotation)

	if Input.is_action_just_pressed("fire") and hasStaticBolt:
		# Yeet the static bolt
		staticBolt.queue_free()
		hasStaticBolt = false

		# Generate a new bolt that we will apply momentum to
		# TODO: Obviously, need a better way to access the "world" to add the bolt to the "world" node
		# 		Or some better way to make it a freestanding agent?
		# NOTE: We have the luxury of not worrying about colliding with player because
		#		collision detection will happen on an opposing client (if "my arrow" hits "someone", not if "an arrow" hits "me")
		var newBoltToShoot = load("res://model_nodes/DynamicBoltItem.tscn").instantiate()
		newBoltToShoot.scale = Vector3(0.64, 0.64, 0.64) # Should be making these params in the scene, I don't like a fixed number like this
		newBoltToShoot.set_position(originBoltPosition)
		newBoltToShoot.set_rotation(originBoltRotation)
		get_parent().get_parent().add_child(newBoltToShoot)
		newBoltToShoot.fire(4)

		# Create a new static bolt, wait a sec to prevent collision
		await get_tree().create_timer(1).timeout
		var newStaticBolt = load("res://assets/StaticBolt.glb").instantiate()
		newStaticBolt.position.y += 0.722 # Also, prevent this lmao
		add_child(newStaticBolt)
		staticBolt = newStaticBolt
		hasStaticBolt = true



func update_origin_position_rotation(new_position: Vector3, new_rotation: Vector3):
	originBoltPosition = new_position
	originBoltRotation = new_rotation