extends Control
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")
signal LoadGameNo
signal LoadGameYes


func _on_No_pressed():
	emit_signal("LoadGameNo")
