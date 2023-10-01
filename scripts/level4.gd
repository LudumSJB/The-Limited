extends Node2D

@onready var dialog_system = $dialogSystem
@onready var bartender = $Area2D__talk_to_person
@onready var dj = $Area2D__talk_to_person2

var act = 0

func _on_area_2d__talk_to_person_on_talk_initated():
	dialog_system.nextText()

func _on_dialog_system_next_act_started():
	act += 1
	if act == 1:
		bartender.monitoring = false
		dj.monitoring = true

func _on_area_2d__talk_to_person_2_on_talk_initated():
	dialog_system.nextText()
