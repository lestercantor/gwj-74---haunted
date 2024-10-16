extends Node2D
class_name MouseLight

@export var light: PointLight2D

var charge: float = 100:
	set(value):
		charge = clampf(value, 0, 100)

# Boolean checks to if the player is holding down the mouse button 
# And if they can activate the light 
var mouse_down: bool = false
var can_activate_light: bool = true

# Counter to count down delta time which will be reset
var timer: float = 0

func _ready() -> void:
	# Set default properties 
	light.texture_scale = 7
	light.enabled = false
	
func _process(delta: float) -> void:
	# Always get the global position of the mouse for the light
	light.global_position = get_global_mouse_position()
	
	modify_charge(delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_light"):
		mouse_down = true
	elif event.is_action_released("activate_light"):
		mouse_down = false

func modify_charge(delta: float) -> void:
	# Increase timer counter by delta
	timer += delta
	
	# Check if the player is holding down the mouse and the charge is not 0
	if mouse_down and can_activate_light and charge != 0:
		# Enable the light when conditions are true
		light.enabled = true
		
		# After timer is bigger than 0.1 (after getting increased by delta) execute inside the code
		if timer > 0.1:
			charge -= 1.8
			# Reset the timer counter
			timer = 0
			
	else:
		light.enabled = false
		
		if timer > 0.1 and charge != 100:
			charge += 0.7
			timer = 0
			# Make sure the player can't spam activating the light by adding this check if charge is less than 30 
			# After holding it down and then they release it or reach 0 charge
			if charge < 30:
				can_activate_light = false
			else:
				can_activate_light = true
