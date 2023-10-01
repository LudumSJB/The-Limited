extends Node2D

signal DudeGoOut

@onready var targetpos = $targetpos
@export var minDistance: float = 0.1
@export var speed: float = 2
@onready var sprite_2d = $targetpos/Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var move = false

func _ready():
	sprite_2d.visible = false

func _process(delta):
	if move:
		if animated_sprite_2d.position.distance_to(targetpos.position) > minDistance:
			animated_sprite_2d.position = animated_sprite_2d.position.move_toward(targetpos.position, delta * speed)
		else:
			DudeGoOut.emit()
			queue_free()

func startMoving():
	move = true


func _on_dialog_system_on_dialog_close():
	startMoving()
