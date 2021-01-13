extends KinematicBody2D
class_name Creature

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func cal_speed(vector):
	var temp_vector=Vector2(abs(vector.x),abs(vector.y))
	return 2- 2*temp_vector.angle()/PI
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
