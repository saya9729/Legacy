extends KinematicBody2D
const ACCELERATION = 500
const MAX_SPEED = 50
const MAX_SPRINT_SPEED = 85
const FRICTION = 500
var velocity =  Vector2.ZERO

onready var fly = $Fly
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = 2*(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		fly.play("Stand")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			
	else:
		fly.play("Stand")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity =  move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	queue_free()
