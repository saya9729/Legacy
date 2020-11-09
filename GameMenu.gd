extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event.is_action_pressed("GameMenu"):
		var pause_state =  !get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
