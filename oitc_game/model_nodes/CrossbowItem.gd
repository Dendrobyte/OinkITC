extends Node3D

"""
This will handle all the crossbow functionality, starting with just shooting the bolt.

The bolt count, when implemented, should be on the PLAYER movement script! This way we only have to go one level up/down for bolt/count respectively.
For now, just one until it's shot.
"""

@export_range(1, 200)
var bolt_speed: int = 10 # TODO: move this?

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		$BoltItem.fire(bolt_speed)
		print("Fired at speed ", bolt_speed, "!")
