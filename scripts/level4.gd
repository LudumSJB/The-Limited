extends Node2D

@onready var dialog_system = $dialogSystem
@onready var bartender = $Area2D__talk_to_person
@onready var dj = $Area2D__talk_to_person2
@onready var action_dance = $action_dance
@onready var music = $music

var minigame = preload("res://scenes/RhythmMinigame.tscn")
var minigame_instance: Node
var act = 0

func startMinigame():
	print("startMinigame")
	minigame_instance = minigame.instantiate()
	minigame_instance.MiniGameEnded.connect(endMinigame)
	add_child(minigame_instance)
	music.stop()
#	minigame_instance._on_start_mini_game()
	
func endMinigame():
	print("endMinigame")
	minigame_instance.queue_free()
	music.play()

func _on_area_2d__talk_to_person_on_talk_initated():
	dialog_system.nextText()

func _on_dialog_system_next_act_started():
	act += 1
	if act == 1:
		bartender.monitoring = false
		# can talk to dj
		dj.monitoring = true
		# dance floor is open
		action_dance.monitoring = true

func _on_area_2d__talk_to_person_2_on_talk_initated():
	dialog_system.nextText()


func _on_action_dance_on_action_initated():
	print("_on_action_dance_on_action_initated")
	startMinigame()
