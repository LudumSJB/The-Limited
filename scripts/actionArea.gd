extends Area2D

signal OnActionInitated

@onready var sprite_2d = $Sprite2D
@onready var rich_text_label = $Sprite2D/RichTextLabel
@onready var indicator = $indicator

@export var label_text: String = "talk to"

var action_initiated: bool = false
var bodyEntered: bool = false

func _ready():
	rich_text_label.clear()
	rich_text_label.append_text(label_text)
	sprite_2d.visible = false
	if monitoring:
		indicator.visible = true
	else:
		indicator.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("action_button") && sprite_2d.visible:
		sprite_2d.visible = false
		OnActionInitated.emit()
		action_initiated = true
		queue_free()
	elif monitoring && !action_initiated && !bodyEntered:
		indicator.visible = true

func _on_body_entered(_body):
	bodyEntered = true
	sprite_2d.visible = true
	indicator.visible = false

func _on_body_exited(_body):
	bodyEntered = false
	sprite_2d.visible = false
	if !action_initiated:
		indicator.visible = true
