extends CanvasLayer
@onready var quit_button = $Control/QuitButton
@onready var play_button = $Control/PlayButton

func _ready():
	if OS.has_feature("web"):
		quit_button.visible = false
	play_button.grab_focus() # set focus to first button

func _process(delta):
	# for gamepad menu navigation
	if Input.is_action_just_released("action_button"):
		var focusOwner: Control = get_viewport().gui_get_focus_owner()
		focusOwner.emit_signal("pressed")


func play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/root.tscn")
	
func minigames_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MinigamesSelect.tscn")


func quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
