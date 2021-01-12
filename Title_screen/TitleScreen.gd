extends Control

onready var game_saver  : Node = $GameSaver
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")

func _ready():
	get_tree().paused
	character_ui.visible = false
	
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_New_Game_pressed():
	var new_game = load("res://Title_screen/NewGameScreen.tscn").instance()
	add_child(new_game)
	get_node("Black").visible = true
	get_node("NewGameScreen").connect("CloseNewGameNo", self, "CloseNewGame")
	get_node("NewGameScreen").connect("CloseNewGameYes", self, "CloseNewGame1")

func CloseNewGame():
	get_node("Black").visible = false
	get_node("NewGameScreen").queue_free()

func CloseNewGame1():
	get_node("Black").visible = false
	get_node("NewGameScreen").queue_free()
	var pause_state =  false
	get_tree().paused = pause_state
	visible = pause_state
	character_ui.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_Continue_pressed():
	var pause_state =  false
	get_tree().paused = pause_state
	visible = pause_state
	character_ui.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	game_saver.load(1)


func _on_Exit_pressed():
	get_tree().quit()
