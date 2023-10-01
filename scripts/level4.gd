extends Node2D

@onready var dialog_system = $dialogSystem
@onready var area_2d__talk_to_person = $Area2D__talk_to_person
@onready var area_2d__talk_to_person_2 = $Area2D__talk_to_person2

func _on_area_2d__talk_to_person_on_talk_initated():
	dialog_system.nextText()

func _on_dialog_system_next_act_started():
	area_2d__talk_to_person.monitoring = false
	area_2d__talk_to_person_2.monitoring = true

func _on_area_2d__talk_to_person_2_on_talk_initated():
	dialog_system.nextText()
