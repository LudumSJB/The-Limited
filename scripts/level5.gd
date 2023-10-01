extends Node2D

@onready var dialog_system = $dialogSystem


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dancer_dude_dude_go_out():
	dialog_system.nextText()
