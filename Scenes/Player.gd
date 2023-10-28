extends CharacterBody2D

# AnimationTree reference
@onready var animation_tree : AnimationTree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

# Player states
@export var speed = 100

# --------------------------------- Movement & Animations -----------------------------------

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()
	
	# Sprinting
	if Input.is_action_pressed("ui_sprint"):
		speed = 150
	elif Input.is_action_just_released("ui_sprint"):
		speed = 100
		
	if direction:	
		velocity = direction * speed 
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
func update_animation_parameters():		
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
			
	#if(Input.is_action_just_pressed("ui_attack")):
		#animation_tree["parameters/conditions/attack"] = true
	#else:
		#animation_tree["parameters/conditions/attack"] = false
	
	if(direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
		#animation_tree["parameters/Attack/blend_position"] = direction
