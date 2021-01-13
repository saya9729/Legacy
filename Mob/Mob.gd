extends Creature

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $Sprite
onready var hurtbox = $Hurtbox

const KNOCKBACK_SPEED = 130
const KICK_KNOCKBACK_SPEEED = 200
const KNOCKBACK_FRICTION = 350

const ACCELERATION = 500
const MAX_SPEED = 50
const FRICTION = 200

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

var knockback_direction = Vector2.ZERO
var knockback_velocity = Vector2.ZERO
var velocity = Vector2.ZERO

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

func _physics_process(delta):
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
	knockback_velocity = move_and_slide(knockback_velocity)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				var angle_ratio=cal_speed(direction)
				velocity = velocity.move_toward(direction * MAX_SPEED*angle_ratio, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)
	
	
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	if area.damage == 3:
		knockback_direction = $Hurtbox.global_position - area.get_parent().global_position
		knockback_direction = knockback_direction.normalized()
		knockback_velocity = knockback_direction * KNOCKBACK_SPEED
	elif area.damage == 1:
		knockback_direction = $Hurtbox.global_position - area.get_parent().global_position
		knockback_direction = knockback_direction.normalized()
		knockback_velocity = knockback_direction * KICK_KNOCKBACK_SPEEED
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position 
