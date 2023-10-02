extends Area2D

signal OnActionInitated

@onready var sprite_2d = $Sprite2D
@onready var rich_text_label = $Sprite2D/RichTextLabel
@onready var indicator = $indicator

var questIconMoveRange: float = 5
var questIconMoveSpeed: float = 10
@export var label_text: String = "talk to"
@export var remove_after_activation: bool = true

var bodyEntered: bool = false
var questIconStartPos: Vector2
var questIconMoveDir: int = 0

func _ready():
	questIconStartPos = indicator.global_position
	rich_text_label.clear()
	rich_text_label.append_text(label_text)
	sprite_2d.visible = false
	if monitoring:
		indicator.visible = true
	else:
		indicator.visible = false

func _process(delta):
	if Input.is_action_just_pressed("action_button") && sprite_2d.visible:
		sprite_2d.visible = false
		OnActionInitated.emit()
		if remove_after_activation:
			queue_free()
	elif monitoring && !bodyEntered:
		indicator.visible = true
	
	# move quest indicator
	if questIconMoveDir == 0:
		indicator.global_position.y += delta * questIconMoveSpeed
		if indicator.global_position.y > questIconStartPos.y + questIconMoveRange:
			questIconMoveDir = 1
	elif questIconMoveDir == 1:
		indicator.global_position.y -= delta * questIconMoveSpeed
		if indicator.global_position.y < questIconStartPos.y - questIconMoveRange:
			questIconMoveDir = 0

func _on_body_entered(_body):
	bodyEntered = true
	sprite_2d.visible = true
	indicator.visible = false

func _on_body_exited(_body):
	bodyEntered = false
	sprite_2d.visible = false
	indicator.visible = true
