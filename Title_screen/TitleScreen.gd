extends Control

onready var file = 'res://save/savefolder/lastest.txt'
onready var game_saver  : Node = $GameSaver
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")

func _ready():
	get_tree().paused = true
	character_ui.visible = false
	
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_New_Game_pressed():
	var new_game = load("res://Title_screen/NewGameScreen.tscn").instance()
	add_child(new_game)
	get_node("Black").visible = true
	get_node("Menu/CenterRow/Button").visible = false
	get_node("NewGameScreen").connect("NewGameNo", self, "CloseNewGame")
	get_node("NewGameScreen").connect("NewGameYes", self, "OpenNewGame")

func CloseNewGame():
	get_node("Black").visible = false
	get_node("Menu/CenterRow/Button").visible = true
	get_node("NewGameScreen").queue_free()

func OpenNewGame():
	get_node("Black").visible = false
	get_node("NewGameScreen").queue_free()
	get_node("Menu/CenterRow/Button").visible = true
	get_tree().paused = false
	visible = false
	character_ui.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_Continue_pressed():
	get_tree().paused = false
	visible = false
	character_ui.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var name = load_file(file)
	game_saver.load(int(name))


func _on_Exit_pressed():
	get_tree().quit()


func _on_Load_Game_pressed():
	var load_game = load("res://Title_screen/LoadGameScreen.tscn").instance()
	add_child(load_game)
	get_node("Black").visible = true
	get_node("Menu/CenterRow/Button").visible = false
	get_node("LoadGameScreen").connect("LoadGameNo", self, "CloseLoadGame")
	get_node("LoadGameScreen").connect("LoadGameYes", self, "LoadGame")
	
func CloseLoadGame():
	get_node("Black").visible = false
	get_node("Menu/CenterRow/Button").visible = true
	get_node("LoadGameScreen").queue_free()
func LoadGame(save):
	if (game_saver.load(save)):
		get_node("Black").visible = false
		get_node("LoadGameScreen").queue_free()
		get_node("Menu/CenterRow/Button").visible = true
		get_tree().paused = false
		visible = false
		character_ui.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		pass




func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	var line = ""
	while not f.eof_reached():
		line = f.get_line()
	f.close()
	return line


func _on_Setting_pressed():
	get_node("SettingGameScreen").visible = true
	get_node("Black").visible = true
	get_node("SettingGameScreen").connect("Settingback", self, "Settingback")
func Settingback():
	get_node("Black").visible = false
	get_node("SettingGameScreen").visible = false
