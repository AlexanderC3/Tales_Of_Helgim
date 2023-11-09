extends Node2D

@onready var camera : Camera2D = $Player/Camera2D as Camera2D
@onready var player : CharacterBody2D = $Player as CharacterBody2D
@onready var outside_sprite: Sprite2D = $"Huis Zonder Shader -> Jitter"

# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.max_fps = 60
	#Engine.physics_jitter_fix = 10
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#camera.global_position = lerp(camera.global_position, player.global_position, delta * 10)
	#outside_sprite.global_position = lerp(outside_sprite.global_position, player.global_position, delta*100)
	pass
