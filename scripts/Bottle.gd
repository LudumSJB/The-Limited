extends RigidBody2D

var speed = 5000

func _ready():
	add_force_on_creation()
	pass # Replace with function body.

func _process(delta):
	rotate(1)

func add_force_on_creation():
	apply_force(Vector2(2000, -speed))
