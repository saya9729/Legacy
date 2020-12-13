extends KinematicBody2D


onready var fly = $Fly
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func move_state(delta):
	fly.play("Stand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	queue_free()
