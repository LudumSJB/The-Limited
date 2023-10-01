extends Node2D

signal change_to_next_scene
signal shake_camera
signal add_score(amount: int)

@onready var root = $"."
@onready var score_label = $ScoreLabel

var minigame_is_playing: bool = false

var current_level: int = 0
var levels = [
	"level1",
	"level2",
	"level3",
	"level4",
	"level5",
	"level6"
]

# store global vars here that need to stay between scenes
var game_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		game_score = 0
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	
	if Input.is_action_just_pressed("next_level"):
		next_level()

func next_level():
	# change level node to next one
	
	# remove current level node
	var levelname = levels[current_level]
	var levelNode = get_node(levelname)
	levelNode.queue_free()
	
	# instantiate next level node
	current_level += 1
	levelname = levels[current_level]	
	var new_scene = load("res://scenes/" + levelname + ".tscn").instantiate()
	add_child(new_scene)
	move_child(new_scene, 0)

func _on_change_to_next_scene():
	next_level()

func AddScore(amount: int):
	game_score += amount
	score_label.text = "score: " + str(game_score)
	
func GameOver():
	# TODO: show game over screen.
	print("game over!")

func ShakeCamera():
	shake_camera.emit()
	
func MiniGameStarted():
	minigame_is_playing = true
	
func MiniGameEnded():
	minigame_is_playing = false

