extends Area2D

@onready var timing_accuracy_bar = $"../../../.."

@export var canHit = false

signal playerHit
signal playerMiss

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_active:
		check_if_player_can_hit()
	
func activateMinigame():
	is_active = true

func endMinigame():
	is_active = false
	
func check_if_player_can_hit():
	if canHit == true and Input.is_action_just_pressed("action_button"): # checks for when the player is able to hit and if they do hit
		playerHit.emit()
	elif canHit == false and Input.is_action_just_pressed("action_button"): # checks for when the player is not able to hit and if they still do hit
		playerMiss.emit()

func player_on_point(area):
	if area.name == "HitArea": # checks if the current collision area is a hittable area
		canHit = true

func player_off_point(area):
	if area.name == "HitArea": # checks if the current collision area is a non-hittable area
		canHit = false
	
func player_on_time():
	print("On Time!")
	timing_accuracy_bar.onTime()
	
func player_not_on_time():
	print("You Fucked Up!")
	timing_accuracy_bar.notOnTime()
