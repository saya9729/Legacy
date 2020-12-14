extends KinematicBody2D


onready var fly = $Fly

func move_state(delta):
	fly.play("Stand")

func _on_Hurtbox_area_entered(area):
	queue_free()
