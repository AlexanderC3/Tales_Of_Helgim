extends CharacterBody2D

# AnimationTree reference
@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

# Player states
@export var speed = 100

# Composition Sprites
@onready var HatSprite = $Node2D/hat
const composite_sprites = preload("res://Scripts/CompositeSprites.gd")

var curr_hair : int = 0

# --------------------------------- Movement & Animations -----------------------------------

func _ready():
	animation_tree.active = true
	HatSprite.texture = composite_sprites.hat_spritesheet[curr_hair]
	
func _process(delta):
	update_animation_parameters(delta)

func _physics_process(delta):
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()
	
	# Sprinting
	if Input.is_action_pressed("ui_sprint"):
		speed = 150
	elif Input.is_action_just_released("ui_sprint"):
		speed = 100
		
	# Dashing
	if Input.is_action_just_pressed("ui_dash"):
		speed = 500
		await get_tree().create_timer(0.5).timeout # waits for 1 second
		speed = 100
			
	if direction:	
		velocity = direction * speed 
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
	
func update_animation_parameters(delta):			
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
					
	if(Input.is_action_just_pressed("ui_dash")):
		animation_tree["parameters/conditions/is_dashing"] = true
		
	else:
		animation_tree["parameters/conditions/is_dashing"] = false
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
		animation_tree["parameters/dash/blend_position"] = direction
		#animation_tree["parameters/Attack/blend_position"] = direction

func _on_change_hat_pressed():
	curr_hair = (curr_hair + 1) % composite_sprites.hat_spritesheet.size()
	HatSprite.texture = composite_sprites.hat_spritesheet[curr_hair]
