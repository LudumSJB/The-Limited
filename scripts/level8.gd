extends Node2D

@onready var button = $Control/button

func _ready():
	button.grab_focus() # set focus to first button
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	
