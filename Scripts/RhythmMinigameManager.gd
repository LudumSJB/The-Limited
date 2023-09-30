extends CanvasLayer

@export var playerScore = 0
@export var scoreToAdd = 15
@export var scoreToMinus = 5
@export var scoreLabel:Label

func _ready():
	scoreLabel = get_node("ScoreLabel")
	pass

func hit_note():
	playerScore += scoreToAdd
	scoreLabel.text = "Score: " + str(playerScore)

func miss_note():
	if playerScore - scoreToMinus < 0:
		playerScore = 0
	else:
		playerScore -= scoreToAdd
	scoreLabel.text = "Score: " + str(playerScore)
