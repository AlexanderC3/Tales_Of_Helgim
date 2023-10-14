extends CharacterBody2D

# Node references
@onready var animation_sprite = $AnimatedSprite2D

# Player states
@export var speed = 75
var is_attacking = false

#direction and animation to be updated throughout game state
var new_direction = Vector2(0,1) #only move one spaces
var animation

@onready var sprite = $AnimatedSprite2D

# --------------------------------- Movement & Animations -----------------------------------

func get_input():
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		
	# Normalize movement
	if input_direction.length() > 1:
		input_direction = input_direction.normalized()
	# Sprinting
	if Input.is_action_pressed("ui_sprint"):
		speed = 130
	elif Input.is_action_just_released("ui_sprint"):
		speed = 75
	velocity = input_direction * speed 
	return input_direction

func _physics_process(delta):
	var direction = get_input()
	if is_attacking == false:
		move_and_slide()
		player_animations(direction)
	# If no input is pressed, idle
	if !Input.is_anything_pressed():
		if is_attacking == false:
			animation  = "idle_" + returned_direction(new_direction)	
				
func _input(event):
	#input event for our attacking, i.e. our shooting
	if event.is_action_pressed("ui_attack"):
		#attacking/shooting anim
		is_attacking = true
		var animation  = "attack_" + returned_direction(new_direction)
		animation_sprite.play(animation)

# Animation Direction
func returned_direction(direction : Vector2):
	#it normalizes the direction vector to make sure it has length 1 (1, or -1 up, down, left, and right) 
	var normalized_direction  = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.y > 0 && normalized_direction.x == 0:
		return "down"
	elif normalized_direction.y < 0 && normalized_direction.x == 0:
		return "up"
	elif normalized_direction.x > 0 && normalized_direction.y == 0:
		#(right)
		$AnimatedSprite2D.flip_h = false
		return "side"
	elif normalized_direction.x < 0 && normalized_direction.y == 0:
		#flip the animation for reusability (left)
		$AnimatedSprite2D.flip_h = true
		return "side"
	elif normalized_direction.y > 0 && normalized_direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		return "down_right"
	elif normalized_direction.y < 0 && normalized_direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		return "up_right"
	elif normalized_direction.y > 0 && normalized_direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		return "down_right"
	elif normalized_direction.y < 0 && normalized_direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		return "up_right"
		
	#default value is empty
	return default_return
	
# Animations
func player_animations(direction : Vector2):
	#Vector2.ZERO is the shorthand for writing Vector2(0, 0).
	if direction != Vector2.ZERO:
		#update our direction with the new_direction
		new_direction = direction
		#play walk animation, because we are moving
		animation = "walk_" + returned_direction(new_direction)
		animation_sprite.play(animation)
	else:
		#play idle animation, because we are still
		animation  = "idle_" + returned_direction(new_direction)
		animation_sprite.play(animation)
		
# Reset Animation states
func _on_animated_sprite_2d_animation_finished():
	is_attacking = false
	
