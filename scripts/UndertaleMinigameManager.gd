extends Node2D

signal PlayerLose
signal GivePoint

@onready var score_label = $ScoreLabel

var timeBetweenPointsGiven: float = 1
var pointTimer = 0
var score: int = 0

func setScoreOnLabel(amount: int):
	score_label.text = "score: " + str(amount)
	score = amount

func updateScoreLabel():
	score_label.text = "score: " + str(score)

func _process(delta):
	pointTimer += delta
	if pointTimer >= timeBetweenPointsGiven:
		pointTimer = 0
		GivePoint.emit()
		score += 1
		updateScoreLabel()


func player_lose_internal(): # this is the signal from the main player - required as player is not visible to root tree
	PlayerLose.emit() # emit the main player loss signal
	print("loss") # edit this to anything you need
	pass 
