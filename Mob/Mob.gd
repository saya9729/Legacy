extends KinematicBody2D


onready var fly = $Fly

const KNOCKBACK_SPEED = 170
const KNOCKBACK_FRICTION = 350

var knockback_direction = Vector2.ZERO
var knockback_velocity = Vector2.ZERO

func _physics_process(delta):
	fly.play("Stand")
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
	knockback_velocity = move_and_slide(knockback_velocity)

func _on_Hurtbox_area_entered(area):
	knockback_direction = $Hurtbox.global_position - area.global_position
	knockback_direction = knockback_direction.normalized()
	knockback_velocity = knockback_direction * KNOCKBACK_SPEED
