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
	get_node("NewGameScreen").connect("NewGameNo", self, "CloseNewGame")
	get_node("NewGameScreen").connect("NewGameYes", self, "OpenNewGame")

func CloseNewGame():
	get_node("Black").visible = false
	get_node("NewGameScreen").queue_free()

func OpenNewGame():
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


func _on_Load_Game_pressed():
	var continue_game = load("res://Title_screen/LoadGameScreen.tscn").instance()
	add_child(continue_game)
	get_node("Black").visible = true
	get_node("LoadGameScreen").connect("LoadGameNo", self, "CloseLoadGame")
	get_node("LoadGameScreen").connect("LoadGameNo", self, "CloseNewGame1")
func CloseLoadGame():
	get_node("Black").visible = false
	get_node("LoadGameScreen").queue_free()
