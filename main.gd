extends KinematicBody2D
onready var timer=get_node("Timer")
onready var timer2=get_node("Timer2")
var hp = 25
var hp1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ACCELERATION = 500
const MAX_SPEED = 50
const MAX_SPRINT_SPEED = 100
const FRICTION = 500

var velocity =  Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.func _process(delta):

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = 2*(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Stand/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Stand")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity =  move_and_slide(velocity)
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	timer.set_wait_time(2)
	timer.start()
func _on_Timer_timeout():
	timer2.set_wait_time(0.5)
	timer2.start()
func _heal():
	while(hp%20!=0 and hp1==hp):
		hp+=1

func _on_Timer2_timeout():
	hp1=hp
	_heal()
