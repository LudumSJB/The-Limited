extends Node2D

@onready var dialog_system = $dialogSystem


func _on_area_2d__talk_to_security_on_talk_initated():
	dialog_system.nextText()
