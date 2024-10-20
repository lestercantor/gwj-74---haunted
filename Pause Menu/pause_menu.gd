extends Control

func _notification(what: int) -> void:
	match what:
		Node.NOTIFICATION_PAUSED:
			hide()
		Node.NOTIFICATION_UNPAUSED:
			show()
			$Panel/Menu.hide()
			$Panel/VBoxContainer.show()



func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Art Assets/Art Scenes/MainMenuBackground.tscn")


func _on_resume_pressed() -> void:
	get_tree().paused = false


func _on_settings_pressed() -> void:
	$Panel/Menu.show()
	$Panel/VBoxContainer.hide()


func _on_menu_back_button_pressed() -> void:
	$Panel/VBoxContainer.show()
