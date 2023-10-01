extends Node2D

signal change_to_next_scene
signal shake_camera
signal add_score(amount: int)

signal stop_music
signal play_music
signal request_change_music

@onready var root = $"."
@onready var score_label = $ScoreLabel

@onready var music_1_street = $music1_street
@onready var music_2_hotdog = $music2_hotdog
@onready var music_3_club = $music3_club
@onready var music_4_club_2 = $music4_club2
@onready var music_5_toilet = $music5_toilet

var minigame_is_playing: bool = false

var current_level: int = 0
var levels = [
	"level1",
	"level2",
	"level3",
	"level4",
	"level5",
	"level6",
	"level7",
	"level8"
]

var songPerLevelStart = [
	0,0,0,0,1,1,0,0
]
var songPerLevelEnd = [
	0,0,0,1,1,1,0,0
]
var songTypePerLevel = [
	0,1,0,2,3,3,2,0
]
var audioPlayers: Array[AudioStreamPlayer2D]
var current_audio_player: AudioStreamPlayer2D
var current_playback_position: float = 0
# store global vars here that need to stay between scenes
var game_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	audioPlayers.append_array([
		music_1_street,
		music_2_hotdog,
		music_3_club,
		music_4_club_2,
		music_5_toilet
	])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		game_score = 0
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	
	if Input.is_action_just_pressed("next_level") && OS.has_feature("debug"):
		next_level()

func next_level():
	# change level node to next one
	
	# remove current level node
	var levelname = levels[current_level]
	var levelNode = get_node(levelname)
	levelNode.queue_free()
	
	# instantiate next level node
	current_level += 1
	levelname = levels[current_level]
	print("changing to scene: '", levelname, "'")
	var new_scene = load("res://scenes/" + levelname + ".tscn").instantiate()
	add_child(new_scene)
	move_child(new_scene, 0)
	change_music()

func change_music():
	var lastSong = songPerLevelEnd[current_level-1]
	var currentSong = songPerLevelStart[current_level]
	if lastSong == currentSong:
		# need to check which level to play it from right point
		var lastPlayer: AudioStreamPlayer2D
		for p in audioPlayers:
			if p.playing:
				lastPlayer = p
		var playbackPos = lastPlayer.get_playback_position()
		var player = audioPlayers[current_level]
		lastPlayer.stop()
		player.play(playbackPos)
	else:
		# different song, can play from start.
		var player = audioPlayers[current_level]
		for p in audioPlayers:
			p.stop()
		player.play()

func _on_change_to_next_scene():
	next_level()

func AddScore(amount: int):
	game_score += amount
	score_label.text = "score: " + str(game_score)
	
func GameOver():
	# TODO: show game over screen.
	print("game over!")

func ShakeCamera():
	shake_camera.emit()
	
func MiniGameStarted():
	minigame_is_playing = true
	
func MiniGameEnded():
	minigame_is_playing = false

func _on_play_music():
	current_audio_player.play(current_playback_position)

func _on_request_change_music():
	var nextSong = songPerLevelEnd[current_level]
	nextSong.play()

func _on_stop_music():
	for p in audioPlayers:
		if p.playing:
			current_audio_player = p
			current_playback_position = p.get_playback_position()
			p.stop()
