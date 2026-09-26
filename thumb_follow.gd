extends Area2D

@export var left_x: float = 600.0
@export var right_x: float = 1150.0
@export var top_y: float = 150.0
@export var bottom_y: float = 600.0
@export var speed: float = 3
@export var shape: float = 0.8
@export var pause_duration: float = 0.12

@onready var music_player_intro = $"../IntroMusic"
@onready var music_player_main = $"../MainMusic"

var played = false
var t: float = 0.0
var pause_timer: float = 0.0
var last_c_sign: float = 1.0

func _ready():
	music_player_intro.finished.connect(_on_intro_finished)
	music_player_intro.play()

func _process(delta):
	
	var mid = (left_x + right_x) * 0.5
	var half = (right_x - left_x) * 0.5
	var mid_y = (top_y + bottom_y) * 0.5
	var half_y = (bottom_y - top_y) * 0.5
	
	if pause_timer > 0.0:
		pause_timer -= delta
		return

	t += delta * speed
	var phase = t * 4
	var s = sin(phase)
	s = sign(s) * pow(abs(s), shape)

	var c_sign = sign(cos(phase))
	if c_sign != 0.0 and c_sign != last_c_sign:
		last_c_sign = c_sign
		s = sign(s)
		pause_timer = pause_duration

	position.x = mid + s * half
	position.y = mid_y + s * half_y * -1
	
func _on_intro_finished():
	music_player_main.finished.connect(_on_main_finished)
	music_player_main.play()
	
func _on_main_finished():
	music_player_main.finished.connect(_on_main_finished)
	music_player_main.play()
