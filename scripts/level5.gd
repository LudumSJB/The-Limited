extends Node2D

@onready var dialog_system = $dialogSystem
@onready var timing_accuracy_bar = $TimingAccuracyBar
@onready var action_area = $actionArea

signal play_minigame


func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()

func _on_timing_accuracy_bar_minigame_won():
	timing_accuracy_bar.deactivateMinigame()
	dialog_system.nextText()

func _on_dancer_dude_dude_go_out():
	dialog_system.nextText()
	action_area.monitoring = true


func _on_action_area_on_action_initated():
	# go to toilet
	action_area.monitoring = false
	print("_on_action_area_on_action_initated")
	dialog_system.nextText()
