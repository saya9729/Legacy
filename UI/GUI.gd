extends Control

onready var file = 'res://save/savefolder/lastest.txt'
func _ready():
	load_file(file)
func _on_Resume_pressed():
	var pause_state =  !get_tree().paused
	get_tree().paused = pause_state
	get_node("GameMenu").visible = pause_state
	get_node("CharacterUI").visible = !pause_state
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("GameMenu"):
		get_tree().paused =!get_tree().paused
		get_node("GameMenu").toggle_visibility()
		get_node("CharacterUI").toggle_visibility()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	var line = ""
	while not f.eof_reached():
		line = f.get_line()
	f.close()
	print(line)
	return
