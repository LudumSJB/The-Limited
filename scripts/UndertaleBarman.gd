extends AnimatedSprite2D

# things that need fixing:
#
# bottle doesn't spawn on barman properly
# bottle won't collid with area (I have no clue as to what I am doing)

@export var slerpSpeed = 200 
var randomPos:Vector2 = Vector2(358, 150)
var rng = RandomNumberGenerator.new()
const bottleScene = preload("res://scenes/bottle.tscn")

func _ready():
	new_barman_position()
	play("Idle")
	pass 


func _process(delta):
	position = position.lerp(randomPos, slerpSpeed * delta)
#	rotate_barman_to_player()
	pass

func new_barman_position():
	await get_tree().create_timer(2).timeout
	play("Idle")
	print("new position")
	randomPos = Vector2(rng.randf_range(380, 533), 150)
	throw_new_bottle()
	new_barman_position()

#func rotate_barman_to_player():
#	if position.x >= 358 and position.x <= 562:
#		flip_h = false
#	else:
#		flip_h = true
		
func throw_new_bottle():
	play("Throw")
	
	await get_tree().create_timer(0.28).timeout
	var bottleInstance = bottleScene.instantiate()
	bottleInstance.position = Vector2(position.x - 450, position.y - 150)
	add_child(bottleInstance)
	play("Idle")
	pass
