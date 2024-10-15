extends Node2D
class_name MouseLight

@export var light: PointLight2D

var charge: float = 100:
	set(value):
		charge = clampf(value, 0, 100)
		
var mouse_down: bool = false

var deplete_timer: float = 0
var increase_timer: float = 0

func _ready() -> void:
	light.texture_scale = 7
	light.enabled = false
	
func _process(delta: float) -> void:
	light.global_position = get_global_mouse_position()
	
	modify_charge(delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_light"):
		mouse_down = true
	elif event.is_action_released("activate_light"):
		mouse_down = false

func modify_charge(delta: float) -> void:
	deplete_timer += delta
	
	if mouse_down and charge > 1.8:
		if deplete_timer > 0.1:
			charge -= 1.8
			deplete_timer = 0
			light.enabled = true
	else:
		if deplete_timer > 0.1 and charge != 100:
			charge += 0.7
			deplete_timer = 0
			light.enabled = false
