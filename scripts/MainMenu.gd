extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass


func player_focus_entered():
	pass # Replace with function body.


func player_focus_exited():
	pass # Replace with function body.


func play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
	pass # Replace with function body.


func quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
