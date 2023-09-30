extends Node2D

signal play_minigame

@onready var security_guy_talk_to_action = $Area2D__talk_to_security/Sprite2D
@onready var dialog_system = $dialogSystem
@onready var timing_accuracy_bar = $TimingAccuracyBar

var root: Node

var triesToWin: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_node("..")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !dialog_system.is_active && security_guy_talk_to_action.visible && Input.is_action_just_released("action_button"):
		security_guy_talk_to_action.visible = false
		dialog_system.nextText()

func _on_play_minigame():
	timing_accuracy_bar.activateMinigame()

func _on_area_2d__talk_to_security_body_entered(body):
	security_guy_talk_to_action.visible = true


func _on_area_2d__talk_to_security_body_exited(body):
	security_guy_talk_to_action.visible = false


func _on_timing_accuracy_bar_not_on_time():
	print("_on_timing_accuracy_bar_not_on_time")
	root.AddScore(-5)
	pass

func _on_timing_accuracy_bar_on_time():
	print("_on_timing_accuracy_bar_on_time")
	triesToWin -= 1
	root.AddScore(10)
	if triesToWin == 0:
		print("minigame won! continue.")
		timing_accuracy_bar.deactivateMinigame()
		dialog_system.nextText()
