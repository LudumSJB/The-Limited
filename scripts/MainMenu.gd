extends CanvasLayer
@onready var quit_button = $Control/QuitButton


func _ready():
	if OS.has_feature("web"):
		quit_button.visible = false


func _process(_delta):
	pass


func play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/root.tscn")
	pass # Replace with function body.


func quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
