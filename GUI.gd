extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(event):
	if event.is_action_pressed("GameMenu"):
		get_node("GameMenu").show();
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Option_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	
	get_node("GameMenu").hide();
