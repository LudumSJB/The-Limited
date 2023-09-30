extends Control

@export var speed = 0.253

func _ready():
	set_process(true)
	pass


func _process(delta):
	speed += 0.003 * delta
	position.y -= speed + delta
	pass
