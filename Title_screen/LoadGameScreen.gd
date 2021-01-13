extends Control
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")
signal LoadGameNo
signal LoadGameYes


func _on_No_pressed():
	emit_signal("LoadGameNo")
func _input(event):
	if event.is_action_pressed("GameMenu"):
		emit_signal("LoadGameNo")

func _on_SaveSlot1_pressed():
	emit_signal("LoadGameYes",1)

func _on_SaveSlot2_pressed():
	emit_signal("LoadGameYes",2)


func _on_SaveSlot3_pressed():
	emit_signal("LoadGameYes",3)


func _on_SaveSlot4_pressed():
	emit_signal("LoadGameYes",4)
