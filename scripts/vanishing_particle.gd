extends CPUParticles2D

@export var wait_time: float = 4
var timer: Timer


func _ready():
	emitting = true
	remove_particle()

func remove_particle():
	# Do some action
	print("remove_particle")
	await get_tree().create_timer(wait_time).timeout # waits for n second
	# Do something afterwards
	print("remove_particle removing.")
	queue_free() # Deletes this node (self) at the end of the frame

