extends CanvasLayer

signal ChangeSceneMainMenu

@onready var rhythm_minigame_button = $Control/RhythmMinigameButton
var root: Node

func _ready():
	root = get_tree().root.get_child(0)
	rhythm_minigame_button.grab_focus() # set focus to first button

func _process(_delta):
	# for gamepad menu navigation
	if Input.is_action_just_released("action_button"):
		var focusOwner: Control = get_viewport().gui_get_focus_owner()
		focusOwner.emit_signal("pressed")


func rhythm_minigame_button_pressed():
	get_tree().change_scene_to_file("res://scenes/RhythmMinigameFreeplay.tscn")


func _on_back_to_start_button_pressed():
	ChangeSceneMainMenu.emit()
#	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_barman_minigame_button_pressed():
		get_tree().change_scene_to_file("res://scenes/barman_minigame_freeplay.tscn")
