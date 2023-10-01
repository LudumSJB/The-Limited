extends Area2D

signal OnActionInitated

@onready var sprite_2d = $Sprite2D
@onready var rich_text_label = $Sprite2D/RichTextLabel

@export var label_text: String = "talk to"

func _ready():
	rich_text_label.clear()
	rich_text_label.append_text(label_text)
	sprite_2d.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("action_button") && sprite_2d.visible:
		sprite_2d.visible = false
		OnActionInitated.emit()

func _on_body_entered(_body):
	sprite_2d.visible = true

func _on_body_exited(_body):
	sprite_2d.visible = false
