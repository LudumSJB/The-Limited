extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/root.tscn")
	pass # Replace with function body.


func quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
