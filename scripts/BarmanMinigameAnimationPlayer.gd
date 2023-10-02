extends AnimationPlayer

signal PlayMusic

func _ready():
	play("barman_intro")
	
var canPlayMusic = false
func _process(_delta):
	if is_playing() == false and canPlayMusic == false:
		PlayMusic.emit()
		canPlayMusic = true
