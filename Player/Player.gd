# Main Function for Main Character
extends KinematicBody2D

var anima_direction="right"
var anima_mode="stand"
var animation
var isRight = true
onready var timer=get_node("Timer")
onready var timer2=get_node("Timer2")

onready var Save_key : String = "Player" + name
var hp = 60
var stamina = 25
var hp1
var stamina1
var hp_limit=100
var stamina_limit=100

const ACCELERATION = 500
const MAX_SPEED = 50
const MAX_SPRINT_SPEED = 85
const FRICTION = 500

enum{
	MOVE,
	ATTACK,
	SHOOT,
	KICK
}

var state = MOVE
var velocity =  Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var bullet = preload("res://Player/combat/bullet.tscn")
var can_fire = true
var rate_of_fire = 0.4
var shooting = false

# Called when the node enters the scene tree for the first time.func _process(delta):
func _process(delta):
	if hp==0:
		var musicNode=$"Audio/Death"
		musicNode.play()
	
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		SHOOT:
			SkillLoop()
		KICK:
			kick_state(delta)	


func SkillLoop():
	if Input.is_action_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		$Position2D.rotation = get_angle_to(get_global_mouse_position())
		var bullet_instance = bullet.instance()
		bullet_instance.position = $Position2D/ShootPoint.get_global_position()
		bullet_instance.rotation = get_angle_to(get_global_mouse_position())
		get_tree().get_root().add_child(bullet_instance)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
	state = MOVE



func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = 2*(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		if Input.is_action_pressed("ui_left"):
				isRight= false
		elif Input.is_action_pressed("ui_right"):
				isRight= true	
		if isRight:
			animationTree.set("parameters/StandRight/blend_position", input_vector)
			animationTree.set("parameters/WalkRight/blend_position", input_vector)
			animationTree.set("parameters/AttackRight/blend_position", input_vector)
			animationTree.set("parameters/KickRight/blend_position", input_vector)
			
			animationState.travel("WalkRight")
		else: 
			animationTree.set("parameters/StandLeft/blend_position", input_vector)
			animationTree.set("parameters/WalkLeft/blend_position", input_vector)
			animationTree.set("parameters/AttackLeft/blend_position", input_vector)
			animationTree.set("parameters/KickLeft/blend_position", input_vector)
			animationState.travel("WalkLeft")	
		
		if stamina != 0 and Input.is_action_pressed("ui_sprint") and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			velocity = velocity.move_toward(input_vector * MAX_SPRINT_SPEED * 0.9, ACCELERATION * delta)
			stamina-=0.5
		elif stamina != 0 and Input.is_action_pressed("ui_sprint") and (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
			velocity = velocity.move_toward(input_vector * MAX_SPRINT_SPEED , ACCELERATION * delta)
			stamina-=0.5
			
		else:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		if isRight:
			animationState.travel("StandRight")
		else:
			animationState.travel("StandLeft")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity =  move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("kick"):
		state = KICK	
	
	if Input.is_action_just_pressed("Shoot"):
		state = SHOOT

func attack_state(delta):
	velocity = Vector2.ZERO
	if isRight:
		animationState.travel("AttackRight")
	else:
		animationState.travel("AttackLeft")		
func attack_anmation_finished():
	state = MOVE
	
func kick_state(delta):
	velocity = Vector2.ZERO
	if isRight:
		animationState.travel("KickRight")
	else:
		animationState.travel("KickLeft")		
func kick_anmation_finished():
	state = MOVE
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _ready():
	timer.set_wait_time(1)
	timer.start()
	animationTree.active = true
func _on_Timer_timeout():
	timer2.set_wait_time(0.5)
	timer2.start()
func _heal():
	if !Input.is_action_pressed("ui_sprint"):
		while(stamina<=stamina_limit and stamina1==stamina):
			stamina+=10
	while(hp%20!=0 and hp1==hp and hp<=hp_limit):
		hp+=1
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

