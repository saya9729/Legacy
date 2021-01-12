extends Control
onready var character_ui = get_node("/root/Node2D/GUI/GUI/CharacterUI")
signal CloseLoadGameNo
signal CloseLoadGameYes

func _ready():
	pass # Replace with function body.


func _on_Yes_pressed():
	emit_signal("CloseNewGameYes")


func _on_No_pressed():
	emit_signal("CloseNewGameNo")
