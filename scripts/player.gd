extends CharacterBody2D

@onready var dialog_system = $"../dialogSystem"
@onready var steps = $steps
@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 120.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var root: Node

func _ready():
	root = get_node("../..")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	if !dialog_system.is_active && !root.minigame_is_playing:
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			if !steps.playing:
				steps.play()
			if direction < 0:
				animated_sprite_2d.flip_h = true
			elif direction > 0:
				animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			steps.stop()
			animated_sprite_2d.play("idle")
	else:
		velocity = Vector2.ZERO
		steps.stop()
		animated_sprite_2d.play("idle")

	move_and_slide()


func _on_dialog_system_hide_player():
	visible = false


func _on_dialog_system_show_player():
	visible = true
