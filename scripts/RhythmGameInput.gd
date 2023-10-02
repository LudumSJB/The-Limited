extends Node2D

signal playerHitNote
signal playerMissNote
signal playerHitNothing

@export var inputKey = ""
@export var noteSprite:Sprite2D
@export var noteArea:Area2D
var pressed = false
var pressedForAnimation = false
var notesInArea = false

func _ready():
	noteSprite = get_node("Note/Sprite2D")
	noteArea = get_node("Note")
	set_process(true)

func _process(_delta):
	check_for_player_input()
	style_on_player_press()
	allow_input_upon_note_entry()

func check_for_player_input():
	if Input.is_action_just_pressed(inputKey):
		pressed = true
	else:
		pressed = false
		
	if Input.is_action_pressed(inputKey):
		pressedForAnimation = true
	else:
		pressedForAnimation = false

func style_on_player_press():
	if pressedForAnimation == true:
		noteSprite.scale = Vector2(0.80, 0.80)
		noteSprite.modulate = Color("#ffffff")
	else:
		noteSprite.scale = Vector2(0.9, 0.9)
		noteSprite.modulate = Color("#706e71")
	
func allow_input_upon_note_entry():
	if noteArea.get_overlapping_areas().size() > 0:
		if pressed:
			noteArea.get_overlapping_areas().front().queue_free()
			playerHitNote.emit()
	else:
		if pressed:
			playerHitNothing.emit()

func scrolling_note_miss(area):
	if area.name == "HittableNote":
		area.queue_free()
		playerMissNote.emit()
