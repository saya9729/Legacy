extends Control
onready var music : Node = $option/column/OST
signal Settingback
func _on_Music_toggled(button_pressed):
	if(button_pressed):
		music.play()
	else:
		music.stop()


func _on_Full_Screen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen


func _on_VFX_toggled(button_pressed):
	pass


func _on_back_pressed():
	emit_signal("Settingback")
func _input(event):
	if event.is_action_pressed("GameMenu"):
		emit_signal("Settingback")
