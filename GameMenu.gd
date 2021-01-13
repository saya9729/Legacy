extends Control

signal returnTitle

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
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.resize(24,15)
	image.save_png("res://UI/saveIcon/1.png")
	
func _on_Options_pressed():
	get_node("OptionMenu").visible = true
	get_node("OptionMenu").connect("OptionClose", self, "OptionClose")

func OptionClose():
	get_node("OptionMenu").visible = false
	
func _on_Load_game_pressed():
	var Load_menu = load("res://UI/LoadgameMenu.tscn").instance()
	add_child(Load_menu)
	get_node("LoadgameMenu").connect("CloseLoadMenu", self, "CloseLoadMenu")
func CloseLoadMenu(ok):
	get_node("LoadgameMenu").queue_free()
	if(ok == "yes"):
		get_tree().paused = false
		visible = false
		get_parent().get_node("CharacterUI").visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_Quit_to_main_menu_pressed():
	visible = false
	get_parent().get_node("TitleScreen").visible = true
	get_tree().paused = false
