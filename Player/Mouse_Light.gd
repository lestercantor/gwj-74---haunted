extends Node2D
class_name MouseLight

@export var light: PointLight2D

func _process(delta: float) -> void:
	light.global_position = get_global_mouse_position()
