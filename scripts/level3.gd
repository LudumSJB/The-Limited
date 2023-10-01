extends Node2D

signal play_minigame

@onready var security_guy_talk_to_action = $Area2D__talk_to_security/Sprite2D
@onready var dialog_system = $dialogSystem
@onready var timing_accuracy_bar = $TimingAccuracyBar


func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()


func _on_timing_accuracy_bar_minigame_won():
	timing_accuracy_bar.deactivateMinigame()
	dialog_system.nextText()


func _on_area_2d__talk_to_security_on_talk_initated():
	dialog_system.nextText()
