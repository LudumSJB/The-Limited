extends Node2D

var menu = preload("res://scenes/MainMenu.tscn")
var minigames = preload("res://scenes/MinigamesSelect.tscn")
var credits = preload("res://scenes/credits.tscn")

var currentSceneInstance: Node

func _ready():
	changeSubSceneToMainMenu()

func changeSubSceneToCredits():
	instantiateScene(credits)
	currentSceneInstance.ChangeSceneMainMenu.connect(changeSubSceneToMainMenu)
	
func changeSubSceneToMinigamesSelect():
	instantiateScene(minigames)
	currentSceneInstance.ChangeSceneMainMenu.connect(changeSubSceneToMainMenu)
	
func changeSubSceneToMainMenu():
	instantiateScene(menu)
	currentSceneInstance.ChangeSceneToMiniGames.connect(changeSubSceneToMinigamesSelect)
	currentSceneInstance.ChangeSceneToCredits.connect(changeSubSceneToCredits)
	
func instantiateScene(packedScene: PackedScene):
	var instance = packedScene.instantiate()
	add_child(instance)
	if currentSceneInstance != null:
		currentSceneInstance.queue_free()
	currentSceneInstance = instance
	
