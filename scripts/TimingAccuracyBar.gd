extends CanvasLayer

signal OnTime
signal NotOnTime

@onready var area_hitter = $Control/Path2D/PathFollow2D/AreaHitter
@onready var timing_accuracy_bar = $"."
@onready var path_follow_2d = $Control/Path2D/PathFollow2D
@onready var path_2d = $Control/Path2D

@export var speed = 0.2 # speed that the input accuracy bar moves at

var rng = RandomNumberGenerator.new()

var path_length: float = 0

func _ready():
	path_length = path_2d.curve.get_baked_length()

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
	print("onTime")
	setRandomProgress()
	OnTime.emit()

func notOnTime():
	print("notOnTime")
	setRandomProgress()
	NotOnTime.emit()
	
func setRandomProgress():
	var progress: float = rng.randf_range(0, path_length)
	path_follow_2d.progress = progress
