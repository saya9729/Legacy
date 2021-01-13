extends Control


func _on_Resume_pressed():
	var pause_state =  !get_tree().paused
	get_tree().paused = pause_state
	get_node("GameMenu").visible = pause_state
	get_node("CharacterUI").visible = !pause_state
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("GameMenu") and !get_node("TitleScreen").visible:
		get_tree().paused =!get_tree().paused
		get_node("GameMenu").toggle_visibility()
		get_node("CharacterUI").toggle_visibility()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
