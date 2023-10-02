extends Node2D

signal play_minigame

@onready var dialog_system = $dialogSystem

var minigame = preload("res://scenes/UndertaleMinigame.tscn")
var minigameInstance: Node
var root: Node

func _ready():
	root = get_tree().root.get_child(0)

func startMinigame():
	minigameInstance = minigame.instantiate()
	add_child(minigameInstance)
	minigameInstance.PlayerLose.connect(onPlayerLost)
	minigameInstance.GivePoint.connect(onAddPoint)
	minigameInstance.setScoreOnLabel(root.game_score)

func onAddPoint():
	root.AddScore(1)

func onPlayerLost():
	minigameInstance.queue_free()
	dialog_system.nextText()

func _on_play_minigame():
	startMinigame()
