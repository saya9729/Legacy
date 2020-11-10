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


func _on_Resume_pressed():
		var pause_state =  !get_tree().paused
		get_tree().paused = pause_state
		visible = pause_state;

func _on_Exit_pressed():
	get_tree().quit();




func _on_Save_game_pressed():
	var Save_menu = load("res://UI/SavegameMenu.tscn").instance()
	add_child(Save_menu)
	get_node("SavegameMenu").connect("CloseSaveMenu", self, "CloseSaveMenu")

func CloseSaveMenu():
	get_node("SavegameMenu").queue_free()
func _on_Options_pressed():
	pass # Replace with function body.


func _on_Load_game_pressed():
	var Load_menu = load("res://UI/LoadgameMenu.tscn").instance()
	add_child(Load_menu)
	get_node("LoadgameMenu").connect("CloseLoadMenu", self, "CloseLoadMenu")
func CloseLoadMenu():
	get_node("LoadgameMenu").queue_free()
