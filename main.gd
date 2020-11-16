extends KinematicBody2D
onready var timer=get_node("Timer")
onready var timer2=get_node("Timer2")

onready var Save_key : String = "Player" + name
var hp = 61
var stamina = 25
var hp1
var stamina1
var hp_limit=100
var stamina_limit=100
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
		if Input.is_action_pressed("ui_sprint"):
			velocity = velocity.move_toward(input_vector * MAX_SPRINT_SPEED, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Stand")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity =  move_and_slide(velocity)
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

		
func _ready():
	timer.set_wait_time(1)
	timer.start()
func _on_Timer_timeout():
	timer2.set_wait_time(0.5)
	timer2.start()
func _heal():
	while(hp%20!=0 and hp1==hp and hp<=hp_limit):
		hp+=1
	while(stamina<=stamina_limit and stamina1==stamina):
		stamina+=10	
func _on_Timer2_timeout():
	hp1=hp
	stamina1=stamina
	_heal()
	
func save(save_game: Resource):
	save_game.data[Save_key] = {
		'health': hp,
		'stamina': stamina,
		'postion':  get_position(),
	}


func load(save_game: Resource):
	var data: Dictionary = save_game.data[Save_key]
	hp = data['health']
	stamina = data['stamina']
	position = data['postion']

