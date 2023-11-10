extends CharacterBody2D

# Movement Variables
@export var speed = 128
@export var dash_speed = 380
var direction : Vector2 = Vector2.ZERO
var dash_vector : Vector2 = Vector2.ZERO

# Animation States
enum{
	MOVE,
	DASH,
	ATTACK
}
var state = MOVE

# Animation References
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

# Composition Sprites
const composite_sprites = preload("res://Scripts/CompositeSprites.gd")
@onready var HatSprite = $Composition_Sprites/hat
var curr_hair : int = 0

# --------------------------------- Movement & Animations -----------------------------------

func _ready():
	animation_tree.active = true
	HatSprite.texture = composite_sprites.hat_spritesheet[curr_hair]
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state(delta)
		ATTACK:
			pass
	
func move_state(delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		dash_vector = direction
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Walk/blend_position", direction)
		animation_tree.set("parameters/Dash/blend_position", direction)
		animation_state.travel("Walk")	
		velocity = direction * speed 
	else:
		animation_state.travel("Idle")
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	# Dashing
	if Input.is_action_just_pressed("ui_dash") && direction != Vector2.ZERO:
		state = DASH
		
func dash_state(delta):
	velocity = dash_vector * dash_speed
	animation_state.travel("Dash")
	
	move_and_slide()
	
func dash_animation_finished():
	state = MOVE
	
func _on_change_hat_pressed():
	curr_hair = (curr_hair + 1) % composite_sprites.hat_spritesheet.size()
	HatSprite.texture = composite_sprites.hat_spritesheet[curr_hair]
