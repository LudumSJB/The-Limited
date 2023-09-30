extends Node2D

signal play_minigame

@onready var timing_accuracy_bar = $TimingAccuracyBar

@export var triesToWin: int = 5

var root: Node


func _ready():
	root = get_node("..")

func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()


func _on_timing_accuracy_bar_not_on_time():
	root.AddScore(-5)
	pass


func _on_timing_accuracy_bar_on_time():
	triesToWin -= 1
	root.AddScore(10)
	if triesToWin == 0:
		print("minigame won! continue.")
