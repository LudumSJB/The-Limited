extends Node2D

signal OnButtonPressed

@onready var button = $Button

@export var button_text: String = "button text here"

func _ready():
	button.text = button_text

func _on_button_pressed():
	OnButtonPressed.emit()
