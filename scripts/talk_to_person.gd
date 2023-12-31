extends Area2D
signal OnTalkInitated
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("action_button") && sprite_2d.visible:
		sprite_2d.visible = false
		OnTalkInitated.emit()

func _on_body_entered(_body):
	sprite_2d.visible = true

func _on_body_exited(_body):
	sprite_2d.visible = false
