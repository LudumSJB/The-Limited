extends CanvasLayer


func _process(_delta):
	if Input.is_action_just_released("exit"):
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
