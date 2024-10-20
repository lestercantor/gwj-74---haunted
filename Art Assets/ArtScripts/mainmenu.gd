extends Control


func _on_start_game_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Level/Level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Art Assets/Art Scenes/SettingsMenu.tscn")
