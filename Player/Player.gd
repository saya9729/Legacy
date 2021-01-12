# Main Function for Main Character
extends KinematicBody2D

var anima_direction="right"
var anima_mode="stand"
var animation
var isRight = true
onready var timer=get_node("Timer")
onready var timer2=get_node("Timer2")

onready var Save_key : String = "Player" + name
var hp = 61
var hp1
var stamina1
var hp_limit=100
var stamina_limit=100

var health=61
var max_health=100
var health_regen_rate=1
var movement_speed_walk=50
var movement_speed_run=85
var stamina=100
var stamina_regen_rate=10
var max_stamina=100
var stamina_cost=0.75
var dead=false
var tired=false
var health_section=20
var in_combat=false
var haste=false

const ACCELERATION = 500
const MAX_SPEED = 50
const MAX_SPRINT_SPEED = 85
const FRICTION = 500

enum{
	MOVE,
	ATTACK,
	KICK,
	SHOOT,
	HURT
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
func _physics_process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if dead:
		var musicNode=$"Audio/Death"
		musicNode.play()
	else:
		match state:
			MOVE:
				haste=false
				if Input.is_action_pressed("ui_sprint"):
					haste=true
				move_state(delta,haste)
			ATTACK:
				attack_state()
			SHOOT:
				pass
			KICK:
				kick_state()
			HURT:
				hurt_state()

func shoot_state():
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
	else:
		state = MOVE

func move_state(delta,haste:bool):
	var input_vector = Vector2.ZERO
	input_vector.x = 2*(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		if Input.is_action_pressed("ui_left"):
				isRight = false
		elif Input.is_action_pressed("ui_right"):
				isRight = true	
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
		
		var angle_ratio=1
		if input_vector.x==0:
			angle_ratio=1
		elif input_vector.y==0:
			angle_ratio=2
		else:
			angle_ratio=sqrt(5)/2.0
			
		if !haste or stamina==0 or tired:
			velocity = velocity.move_toward(input_vector * movement_speed_walk*angle_ratio, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(input_vector * movement_speed_run*angle_ratio, ACCELERATION * delta)
			reduce_stamina(stamina_cost)
		if !haste:
			timer2.start()
		else: timer2.stop()
		
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
	
#	if Input.is_action_just_pressed("Shoot"):
#		state = SHOOT

# warning-ignore:unused_argument
func attack_state():
	velocity = Vector2.ZERO
	if isRight:
		animationState.travel("AttackRight")
	else:
		animationState.travel("AttackLeft")
func attack_anmation_finished():
	state = MOVE
	
func kick_state():
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
func _on_Timer2_timeout():

	auto_regen_stamina()
	
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

func add_health(gain:float):
	health+=gain
	if health>max_health:
		health=max_health
	
func reduce_health(lose:float):
	health-=lose
	if health<0:
		health=0
		dead=true

func add_stamina(gain:float):
	stamina+=gain
	if stamina >=max_stamina:
		stamina=max_stamina
		tired=false
	
func reduce_stamina(lose:float):
	stamina-=lose
	if stamina<0:
		stamina=0
		tired=true
		
func auto_regen_health():
	if health % health_section!=0:
		add_health(health_regen_rate)
		
func auto_regen_stamina():
	add_stamina(stamina_regen_rate)

func hurt_state():
	hp=hp-10

func _on_Hurtbox_area_entered(area):
	hurt_state()
