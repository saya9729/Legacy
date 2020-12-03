extends CanvasLayer


func _input(event):
	if event.is_action_pressed("GameMenu"):
		var pause_state =  !get_tree().paused
		get_tree().paused = pause_state
		get_node("GameMenu").visible = pause_state
		get_node("CharacterUI").visible = !pause_state
func _on_Resume_pressed():
	var pause_state =  !get_tree().paused
	get_tree().paused = pause_state
	get_node("GameMenu").visible = pause_state
	get_node("CharacterUI").visible = !pause_state
