extends Node2D

signal change_to_next_scene

@onready var root = $"."

var current_level: int = 0
var levels = [
	"level1",
	"level2"
]

# store global vars here that need to stay between scenes
var game_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
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
	
func GameOver():
	# TODO: show game over screen.
	print("game over!")
