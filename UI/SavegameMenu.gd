extends Control

signal CloseSaveMenu

onready var game_saver : Node = $GameSaver
var file = "res://save/savefolder/latest"

		
func _on_Back_pressed():
	emit_signal("CloseSaveMenu")


func _on_Save_slot_1_pressed():
	game_saver.save(1)
	save_to_file(file, "1")
	emit_signal("CloseSaveMenu")
func _input(event):
	if event.is_action_pressed("GameMenu"):
		emit_signal("CloseSaveMenu")


func _on_Save_slot_3_pressed():
	game_saver.save(3)
	save_to_file(file, "3")
	emit_signal("CloseSaveMenu")


func _on_Save_slot_4_pressed():
	game_saver.save(4)
	save_to_file(file, "4")
	emit_signal("CloseSaveMenu")


func _on_Save_slot_2_pressed():
	save_to_file(file, "2")
	game_saver.save(2)
	emit_signal("CloseSaveMenu")
func save_the_lastest_file():
	pass
	
func save_to_file(file, name):
	var directory: Directory = Directory.new()
	if not directory.dir_exists(file):
		directory.make_dir_recursive(file)
	var f = File.new()
	var file_path = file +  "/lastest.txt"
	if not f.file_exists(file_path): 
		f.open(file_path,File.WRITE)
		f.store_string(name)
		f.close()
		return
	f.open(file_path, File.READ_WRITE)
	f.seek_end()
	f.store_string("\n")
	f.store_string(name)
	f.close()
	return
