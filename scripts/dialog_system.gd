extends Node2D

@onready var rich_text_label = $Sprite2D/RichTextLabel
@onready var sprite_2d = $Sprite2D
@onready var face = $Sprite2D/face
@onready var face_position_1 = $Sprite2D/facePosition1
@onready var face_position_0 = $Sprite2D/facePosition0
@onready var dialog_position_0 = $dialogPosition0
@onready var dialog_position_1 = $dialogPosition1
@onready var dialog_position_2 = $dialogPosition2
@onready var talking = $talking
@onready var talking_2 = $talking2

@export var showDialogAtSceneStart : bool = true
@export var dialogsPath: String
@export var faces: Array[Texture]
@export var is_active: bool = true;

var sounds: Array[AudioStreamPlayer2D]

var current_dialog: int = 0
var dialogs: Array

var change_scene_after_dialog_close: bool = false
var close_dialog_after_dialog_close: bool = false
var play_minigame_after_dialog_close: bool = false

const timeout_press_time = 0.2
var timeout_press = 0

var text_to_write: String = ""
const timeout_write_character_step: float = 0.01
var write_character_time: float = 0

var root: Node

func _ready():
	print("_ready")
	loadDialogs()
	root = get_node("../..")
	sounds.append(talking)
	sounds.append(talking_2)
	
	if showDialogAtSceneStart:
		showText(dialogs[current_dialog])
	else:
		hideText()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timeout_press >= 0:
		timeout_press -= delta
	if is_active:
		if timeout_press <= 0 && Input.is_action_just_released("action_button"):
#			print("action_button pressed")
			if text_to_write.is_empty():
				if change_scene_after_dialog_close:
#					print("change_scene_after_dialog_close")
					root.emit_signal("change_to_next_scene")
					change_scene_after_dialog_close = false
					return
				if close_dialog_after_dialog_close:
#					print("close_dialog_after_dialog_close")
					hideText()
					close_dialog_after_dialog_close = false
					return
				if play_minigame_after_dialog_close:
#					print("play_minigame_after_dialog_close")
					hideText()
					startMinigame()
					play_minigame_after_dialog_close = false
					return
			if !text_to_write.is_empty():
				writeAllCharacters()
			else:
				nextText()
		if write_character_time <= 0 && !text_to_write.is_empty():
			writeCharacter()
		if write_character_time > 0:
			write_character_time -= delta

func startMinigame():
	var level = get_node("..")
	level.emit_signal("play_minigame")

func loadDialogs():
	var file = FileAccess.open(dialogsPath, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var obj = JSON.parse_string(content)
	if obj == null:
		print("couldn't parse json!")
	dialogs = obj

func nextText():
	timeout_press = timeout_press_time
#	print("nextText")
	current_dialog += 1
	if current_dialog < dialogs.size():
		showText(dialogs[current_dialog])

func hideText():
	sprite_2d.visible = false
	is_active = false

func writeAllCharacters():
	rich_text_label.append_text(text_to_write)
	text_to_write = ""

func getParamString(textToW: String) -> String:
	var i = 1
	# get next characters if we have param here
	while textToW[textToW.length()-1] != "]":
		textToW = textToW + text_to_write[i]
		i += 1
	# get param fully to the end
	var param = textToW.substr(1, textToW.length()-2)
	if param.contains("="):
		param = param.substr(0, param.find("="))
#	print("param: '", param, "'")
	while textToW.count(param) < 2:
		textToW = textToW + text_to_write[i]
		i += 1
	while !textToW.ends_with("]"):
		textToW = textToW + text_to_write[i] # add the last "]"
		i += 1
#	print("textToW: '", textToW, "'")
	return textToW

func writeCharacter():
	var textToWrite: String = text_to_write[0]
	if textToWrite == "[":
		textToWrite = getParamString(textToWrite)
	text_to_write = text_to_write.substr(textToWrite.length(), text_to_write.length())
	rich_text_label.append_text(textToWrite)
	write_character_time = timeout_write_character_step

func showText(dialog):
	is_active = true
	# show new text in dialog
	sprite_2d.visible = true
	rich_text_label.clear()
	text_to_write = dialog.text
	writeCharacter()
	# move dialog box position
	if dialog.has("dialog_position"):
		if dialog.dialog_position == 0:
			sprite_2d.position = dialog_position_0.position
		elif dialog.dialog_position == 1:
			sprite_2d.position = dialog_position_1.position
			sprite_2d.flip_h = false
			face.position = face_position_0.position
		elif dialog.dialog_position == 2:
			sprite_2d.position = dialog_position_2.position
			sprite_2d.flip_h = true
			face.position = face_position_1.position
	
	# change face and its position relative to dialog box
	if dialog.has("face"):
		face.visible = true
		face.texture = faces[dialog.face]
	else:
		face.visible = false
	
	# get actiong from the dialog and do things accordingly
	if dialog.has("action"):
		var action = dialog.action
		print("action: ", action)
		if action == "next_scene":
			change_scene_after_dialog_close = true
		elif action == "close_dialog":
			close_dialog_after_dialog_close = true
		elif action == "minigame":
			play_minigame_after_dialog_close = true
	if dialog.has("sound"):
		var sound = sounds[dialog.sound]
		sound.play()
