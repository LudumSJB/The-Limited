extends CanvasLayer

signal NotOnTime
signal OnTime
signal MinigameWon

@onready var area_hitter = $Control/Path2D/PathFollow2D/AreaHitter
@onready var timing_accuracy_bar = $"."
@onready var path_follow_2d = $Control/Path2D/PathFollow2D
@onready var path_2d = $Control/Path2D
@onready var tries_parent = $Control/triesParent
@onready var sound_success = $sound_success
@onready var sound_fail = $sound_fail

@export var speed = 0.2 # speed that the input accuracy bar moves at
@export var triesToWin: int = 5 # tries needed to be done to win the minigame
@export var tries_indicator: PackedScene # indicator as a scene
@export var indicatorOffset: float = 50 # offset between indicators

var triesSprites: Array[Sprite2D]
var rng = RandomNumberGenerator.new()

var path_length: float = 0

func _ready():
	path_length = path_2d.curve.get_baked_length()
	var indicatorPosition = tries_parent.global_position
	for try in triesToWin:
		var sprite = tries_indicator.instantiate()
		tries_parent.add_child(sprite)
		sprite.global_position = indicatorPosition
		triesSprites.append(sprite)
		indicatorPosition.x += indicatorOffset

func _process(delta):
	path_follow_2d.progress += speed * delta # times smooths this out per frame
	pass
	
func deactivateMinigame():
	timing_accuracy_bar.visible = false
	area_hitter.endMinigame()

func activateMinigame():
	timing_accuracy_bar.visible = true
	area_hitter.activateMinigame()

func onTime():
	triesToWin -= 1
	sound_success.play()
	OnTime.emit()
	if triesSprites.size() > 0:
		var indicatorSprite = triesSprites[triesSprites.size()-1]
		triesSprites.remove_at(triesSprites.size()-1)
		indicatorSprite.queue_free()
	setRandomProgress()
	if triesToWin <= 0:
		MinigameWon.emit()

func notOnTime():
	sound_fail.play()
	NotOnTime.emit()
	setRandomProgress()
	
func setRandomProgress():
	var progress: float = rng.randf_range(0, path_length)
	path_follow_2d.progress = progress
