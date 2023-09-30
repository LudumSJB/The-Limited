extends Node2D

signal play_minigame

@onready var timing_accuracy_bar = $TimingAccuracyBar


func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()
