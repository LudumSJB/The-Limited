extends Node2D

signal OnButtonPressed

@onready var button = $Button

@export var button_text: String = "button text here"

func _ready():
	button.text = button_text

func _on_button_pressed():
	OnButtonPressed.emit()

func grab_focus():
	button.grab_focus()

func _process(_delta):
	# for gamepad navigation
	if Input.is_action_just_released("action_button"):
		if button.has_focus():
			button.emit_signal("pressed")
