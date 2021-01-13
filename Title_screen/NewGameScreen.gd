extends Control
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")
signal NewGameNo
signal NewGameYes



func _on_Yes_pressed():
	emit_signal("NewGameYes")


func _on_No_pressed():
	emit_signal("NewGameNo")
func _input(event):
	if event.is_action_pressed("GameMenu"):
		emit_signal("NewGameNo")
