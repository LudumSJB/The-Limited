extends CanvasLayer

@onready var area_hitter = $Control/Path2D/PathFollow2D/AreaHitter
@onready var timing_accuracy_bar = $"."

func activateMinigame():
	timing_accuracy_bar.visible = true
	area_hitter.activateMinigame()
