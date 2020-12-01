extends RigidBody2D

var bullet_speed = 400
var life_time = 30



func _ready():
	apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	SelfDestruct()
func SelfDestruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()




func _on_bullet_body_entered(body):
	self.hide()
