extends Control

func toggle_visibility():
	visible = !visible
	
func _ready():
	pass 

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
