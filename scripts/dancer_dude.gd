extends Node2D

@onready var targetpos = $targetpos
@export var minDistance: float = 0.1
@export var speed: float = 2
@onready var sprite_2d = $targetpos/Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	sprite_2d.visible = false

func _process(delta):
	if animated_sprite_2d.position.distance_to(targetpos.position) > minDistance:
		animated_sprite_2d.position = animated_sprite_2d.position.move_toward(targetpos.position, delta * speed)
	else:
		queue_free()
