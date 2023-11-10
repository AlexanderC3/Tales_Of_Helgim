extends Node2D

@onready var camera : Camera2D = $Camera2D as Camera2D
@onready var player : CharacterBody2D = $Player as CharacterBody2D

var pos_x : int
var pos_y : int

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.global_position = player.global_position
	Engine.max_fps = 60
	Engine.physics_jitter_fix = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos_x = int(lerp(camera.global_position.x, player.global_position.x, delta*10))
	pos_y = int(lerp(camera.global_position.y, player.global_position.y, delta*10))
	camera.global_position = Vector2(pos_x,pos_y)
