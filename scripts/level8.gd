extends Node2D

signal ChangeSceneMainMenu

@onready var button = $Control/button

func _ready():
	button.grab_focus() # set focus to first button
	
func _on_button_pressed():
	if get_tree().root.get_child(0).name == "root":
		get_tree().change_scene_to_file("res://scenes/game_start_scene.tscn")
	else:
		ChangeSceneMainMenu.emit()
