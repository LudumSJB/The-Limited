extends Control

@export var speed = 0.1 

func _ready():
	set_process(true)
	pass


func _process(delta):
	position.y -= speed + delta
	pass
