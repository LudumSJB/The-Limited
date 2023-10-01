extends CanvasLayer

signal NoteHit
signal NoteMiss
signal PlayerLoss

@export var playerScore = 0
@export var playerMisses = 0
@export var scoreToAdd = 15
@export var scoreToMinus = 5
@export var scoreLabel:Label

var root: Node

func _ready():
	root = get_tree().root.get_child(0)
	if root.name != "root":
		root = null
	scoreLabel = get_node("UIHolder/ScoreLabel")
	pass

func hit_note():
	NoteHit.emit()
	playerScore += scoreToAdd
	scoreLabel.text = "Score: " + str(playerScore)
	if root != null:
		root.AddScore(scoreToAdd)

func miss_note():
	NoteMiss.emit()
	playerScore -= scoreToMinus
	playerMisses += 1
	if playerScore <= 0: playerScore = 0
	if playerMisses == 3: PlayerLoss.emit()
	scoreLabel.text = "Score: " + str(playerScore)
	if root != null:
		root.AddScore(-scoreToMinus)
		root.ShakeCamera()


func on_player_loss():
	var animator:AnimationPlayer = get_node("RhythmMinigameAnimation")
	animator.play("player_lose")
	await get_tree().create_timer(1).timeout
	# get_tree().reload_current_scene() - we need to queuefree and instance this rather than restart the parent scene
