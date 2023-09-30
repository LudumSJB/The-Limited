extends Node2D

@onready var rich_text_label = $Sprite2D/RichTextLabel
@onready var sprite_2d = $Sprite2D
@onready var face = $Sprite2D/face
@onready var face_position_1 = $Sprite2D/facePosition1
@onready var face_position_0 = $Sprite2D/facePosition0

@export var dialogsPath: String
@export var faces: Array[Texture]
var current_dialog: int = 0
#@export() var dialogs: Dictionary
var dialogs: Array

func _ready():
	loadDialogs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_just_pressed("next_text"):
		current_dialog += 1
		showText(dialogs[current_dialog])

func loadDialogs():
	var file = FileAccess.open(dialogsPath, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var json = JSON.new()
	var obj = json.parse_string(content)
	if obj == null:
		print("couldn't parse json!")
	dialogs = obj
	print("dialogs: ", dialogs)
	print("typeof dialogs: ", typeof(dialogs))
	print(dialogs[0].text)

func hideText():
	sprite_2d.visible = false

func showText(dialog):
	sprite_2d.visible = true
	rich_text_label.clear()
	rich_text_label.append_text(dialog.text)
	face.texture = faces[dialog.face]
	if dialog.position == 0:
		sprite_2d.flip_h = false
		face.position = face_position_0.position
	else:
		sprite_2d.flip_h = true
		face.position = face_position_1.position
