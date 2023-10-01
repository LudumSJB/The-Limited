extends Node2D

@onready var dialog_system = $dialogSystem
@onready var bartender = $Area2D__talk_to_person
@onready var dj = $Area2D__talk_to_person2
@onready var action_dance = $action_dance

var minigame = preload("res://scenes/RhythmMinigame.tscn")
var minigame_instance: Node
var act = 0

func startMinigame():
	minigame_instance = minigame.instantiate()
	
func endMinigame():
	minigame_instance.queue_free()

func _on_area_2d__talk_to_person_on_talk_initated():
	dialog_system.nextText()

func _on_dialog_system_next_act_started():
	act += 1
	if act == 1:
		# dance floor is open
		bartender.monitoring = false
		dj.monitoring = false
		action_dance.monitoring = true
	if act == 2:
		# can talk to dj
		bartender.monitoring = false
		dj.monitoring = true
		action_dance.monitoring = false

func _on_area_2d__talk_to_person_2_on_talk_initated():
	dialog_system.nextText()


func _on_action_dance_on_action_initated():
	startMinigame()
