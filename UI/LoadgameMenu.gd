extends Control

signal CloseLoadMenu

onready var game_saver : Node = $GameSaver


func _on_Back_pressed():
	emit_signal("CloseLoadMenu", "no")


func _input(event):
	if event.is_action_pressed("GameMenu"):
		emit_signal("CloseLoadMenu", "no")

func _on_Save_slot_1_pressed():
	if(game_saver.load(1)):
		emit_signal("CloseLoadMenu","yes")
	
func _on_Save_slot_2_pressed():
	if(game_saver.load(2)):
		emit_signal("CloseLoadMenu","yes")


func _on_Save_slot_3_pressed():
	if(game_saver.load(3)):
		emit_signal("CloseLoadMenu","yes")


func _on_Save_slot_4_pressed():
	if(game_saver.load(4)):
		emit_signal("CloseLoadMenu","yes")
