extends Node3D

"""
This will handle all the crossbow functionality, starting with just shooting the bolt.

The bolt count, when implemented, should be on the PLAYER movement script! This way we only have to go one level up/down for bolt/count respectively.
For now, just one until it's shot.
"""

@export_range(1, 200)
var bolt_speed: int = 1 # TODO: move this?
var currBolt
# TODO: hold on to start position, etc. here instead of in _process

# Called when the node enters the scene tree for the first time.
func _ready():
	currBolt = $StaticBolt # The one initially in the scene tree


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		var boltPosition = currBolt.position
		var boltRotation = currBolt.rotation
		# Remove static bolt
		currBolt.queue_free()
		# Spawn in dynamic bolt that is free from parent node
		var dynamicBolt = load("res://model_nodes/DynamicBoltItem.tscn").instantiate()
		dynamicBolt.position = boltPosition; # TODO: Confirm deep copy 
		dynamicBolt.rotation = boltRotation;
		get_parent().get_parent().add_child(dynamicBolt)
		dynamicBolt.fire(bolt_speed)
		print("Fired at speed ", bolt_speed, "!")
		if 5 > 2: # TODO: This just mocks out "if player has more bolts, add a new one"
			currBolt = load("res://assets/StaticBolt.glb").instantiate()
			currBolt.position = boltPosition
			currBolt.rotation = boltRotation
			add_child(currBolt)

