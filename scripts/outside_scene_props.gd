extends Node2D

@export var show_empty_street: bool = false
@onready var city_bg_2 = $city_bg_2

func _ready():
	if !show_empty_street:
		city_bg_2.visible = false
