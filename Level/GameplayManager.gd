extends Node
class_name GameplayManager

var count: int = 0

func _ready() -> void:
	count = 0
	GlobalSignals.painting_counter.connect(change_counter)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		Input.set_custom_mouse_cursor(null)
		
func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused

func change_counter(value: int) -> void:
	count += value
