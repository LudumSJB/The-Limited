extends Node2D

signal PlayerLose
signal GivePoint

@onready var score_label = $ScoreLabel
@onready var lives_parent = $lives_parent

var lives_indicator = preload("res://scenes/heartSprite.tscn")

var timeBetweenPointsGiven: float = 1
var pointTimer = 0
var score: int = 0
var lives: int = 3
var triesSprites: Array[Sprite2D]
var indicatorOffset: float = 30

func _ready():
	addIndicators()
	
func removeIndicator():
	if triesSprites.size()-1 > 0:
		var heartSprite = triesSprites.pop_back()
		heartSprite.queue_free()
	
func addIndicators():
	var indicatorPosition = lives_parent.global_position
	for try in lives:
		var sprite = lives_indicator.instantiate()
		lives_parent.add_child(sprite)
		sprite.global_position = indicatorPosition
		triesSprites.append(sprite)
		indicatorPosition.x += indicatorOffset

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


func _on_player_player_got_hit():
	lives -= 1
	removeIndicator()
