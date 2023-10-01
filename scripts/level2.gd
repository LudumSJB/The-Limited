extends Node2D

signal play_minigame

@onready var timing_accuracy_bar = $TimingAccuracyBar
@onready var dialog_system = $dialogSystem

func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()

func _on_timing_accuracy_bar_minigame_won():
	timing_accuracy_bar.deactivateMinigame()
	dialog_system.nextText()
