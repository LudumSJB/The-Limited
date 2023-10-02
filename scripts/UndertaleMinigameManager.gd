extends Node2D

signal PlayerLose

func _ready():
	pass


func _process(_delta):
	pass


func player_lose_internal(): # this is the signal from the main player - required as player is not visible to root tree
	PlayerLose.emit() # emit the main player loss signal
	pass 
