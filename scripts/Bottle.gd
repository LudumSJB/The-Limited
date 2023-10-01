extends RigidBody2D

var speed = 150000

func _ready():
	add_force_on_creation()
	pass # Replace with function body.

func _process(_delta):
	rotate(3)

func add_force_on_creation():
	apply_force(Vector2(20000, -speed))
