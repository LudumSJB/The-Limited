extends CanvasLayer

func rhythm_minigame_button_pressed():
	get_tree().change_scene_to_file("res://scenes/RhythmMinigameFreeplay.tscn")


func _on_back_to_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
