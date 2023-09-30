extends Node2D

@onready var security_guy_talk_to_action = $Area2D__talk_to_security/Sprite2D
@onready var dialog_system = $dialogSystem

@onready var music = $music


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !dialog_system.is_active && security_guy_talk_to_action.visible && Input.is_action_just_released("action_button"):
		security_guy_talk_to_action.visible = false
		dialog_system.nextText()

func _on_area_2d__talk_to_security_body_entered(_body):
	security_guy_talk_to_action.visible = true


func _on_area_2d__talk_to_security_body_exited(_body):
	security_guy_talk_to_action.visible = false

