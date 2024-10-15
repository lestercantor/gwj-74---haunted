extends Node2D
class_name MouseLight

@export var light: PointLight2D

func _ready() -> void:
	light.texture_scale = 7
	light.enabled = false
	
func _process(delta: float) -> void:
	light.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("activate_light"):
		light.enabled = true
		
		
	elif Input.is_action_just_released("activate_light"):
		light.enabled = false
