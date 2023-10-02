extends Camera2D

@export var decay: float = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset:Vector2 = Vector2(10, 10)  # Maximum hor/ver shake in pixels.
@export var max_roll: float = 0.1  # Maximum rotation in radians (use sparingly).
@export var target: NodePath  # Assign the node this camera will follow.

var trauma: float = 0.0  # Current shake strength.
var trauma_power: int = 2  # Trauma exponent. Use [2, 3].
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()

func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rng.randf_range(-1, 1)
	offset.x = max_offset.x * amount * rng.randf_range(-1, 1)
	offset.y = max_offset.y * amount * rng.randf_range(-1, 1)


func _on_root_shake_camera():
	add_trauma(1)


func _on_rhythm_minigame_shake_camera():
	add_trauma(1)
