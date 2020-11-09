extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("GameMenu"):
		var pause_state =  !get_tree().paused
		visible = false;
		visible = pause_state;


func _physics_process(delta):
	value=get_tree().root.get_node("Node2D").get_node("YSort").get_node("KinematicBody2D").hp
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
