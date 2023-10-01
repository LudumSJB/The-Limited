extends CanvasLayer
@onready var quit_button = $Control/QuitButton


func _ready():
	if OS.has_feature("web"):
		quit_button.visible = false


func play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/root.tscn")


func quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level8.tscn")
