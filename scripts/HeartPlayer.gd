extends Area2D

var lives = 3

@export var speed = 200.0
@export var maxY = 1.0
@export var minY = 1.0
@export var minX = 1.0
@export var maxX = 1.0

func _ready():
	pass 

func _process(delta):
	move_player(delta)
	clamp_player_position()
	pass

func move_player(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("right"): velocity.x += 1
	if Input.is_action_pressed("left"): velocity.x -= 1
	if Input.is_action_pressed("down"): velocity.y += 1
	if Input.is_action_pressed("up"): velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta

func clamp_player_position():
	position.x = clamp(position.x, minX, maxX)
	position.y = clamp(position.y, minY, maxY)

func object_hit_player(body):
	if body.name == "Bottle":
		lives -= 1
		print("lives left: ", lives)
