extends Node
class_name GameplayManager

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
