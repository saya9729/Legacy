extends Control

signal CloseLoadMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game_saver : Node = $GameSaver


func _on_Back_pressed():
	emit_signal("CloseLoadMenu")


func _on_Save_slot_1_pressed():
	game_saver.load(1)
