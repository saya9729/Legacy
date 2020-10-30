extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ACCELERATION = 10
const MAX_SPEED = 50
const MAX_SPRINT_SPEED = 100
const FRICTION = 10

var velocity =  Vector2.ZERO

# Called when the node enters the scene tree for the first time.func _process(delta):

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = 2*(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	elif Input.is_action_pressed("ui_sprint"):
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPRINT_SPEED * delta)
	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_collide(velocity)
	
	
	
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite.play("walk left")
	if Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("stand left")
	
	if Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.play("walk right")
	if Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("stand right")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass