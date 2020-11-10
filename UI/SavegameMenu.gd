extends Control

signal CloseSaveMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game_saver : Node = $GameSaver


func _on_Back_pressed():
	emit_signal("CloseSaveMenu")


func _on_Save_slot_1_pressed():
	game_saver.save(1)
