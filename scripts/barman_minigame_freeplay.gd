extends Node2D


func _process(_delta):
	if Input.is_action_just_released("exit"):
		get_tree().change_scene_to_file("res://scenes/game_start_scene.tscn")


func _on_undertale_minigame_player_lose():
	get_tree().change_scene_to_file("res://scenes/game_start_scene.tscn")
