extends Node2D

signal play_minigame

@onready var timing_accuracy_bar = $TimingAccuracyBar
@onready var dialog_system = $dialogSystem

var root: Node


func _ready():
	root = get_node("..")

func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()


func _on_timing_accuracy_bar_not_on_time():
	root.AddScore(-5)
	root.ShakeCamera()

func _on_timing_accuracy_bar_on_time():
	root.AddScore(10)

func _on_timing_accuracy_bar_minigame_won():
	timing_accuracy_bar.deactivateMinigame()
	dialog_system.nextText()
