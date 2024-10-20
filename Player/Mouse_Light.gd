extends Node2D
class_name MouseLight

var cursorOn = preload("res://Art Assets/UI/MatchstickOn.png")
var cursorOff = preload("res://Art Assets/UI/MatchstickOff.png")

@onready var matchstick_particles: GPUParticles2D = $MatchstickParticles

signal charge_changed

@export var light: PointLight2D
@export var burn_area: Area2D

@export var max_charge: float = 100
var charge: float = max_charge:
	set(value):
		charge = clampf(value, 0, max_charge)
		charge_changed.emit()

# Boolean checks to if the player is holding down the mouse button 
# And if they can activate the light 
var mouse_down: bool = false
var can_activate_light: bool = true

# Counter to count down delta time which will be reset
var timer: float = 0

# Light radius size
@export var max_size: float = 5
@export var min_size: float = 0.5

# Light charge to increase and decrease
@export var light_deplete: float = 1.1
@export var light_charge: float = 1

var light_size: float = max_size:
	set(value):
		light_size = clampf(value, min_size, max_size)
		light.texture_scale = light_size
		
func _ready() -> void:
	# Set default properties 
	light.texture_scale = max_size
	light.enabled = false
	Input.set_custom_mouse_cursor(cursorOff)
	
func _process(delta: float) -> void:
	# Always get the global position of the mouse for the light
	global_position = get_global_mouse_position()
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
		$BurnArea/CollisionShape2D.disabled = false
		# Enable the light when conditions are true
		light.enabled = true
		matchstick_particles.emitting = true
		Input.set_custom_mouse_cursor(cursorOn)
		
		# After timer is bigger than 0.1 (after getting increased by delta) execute inside the code
		if timer > 0.06:
			charge -= light_deplete
			# Reset the timer counter
			timer = 0


	else:
		light.enabled = false
		matchstick_particles.emitting = false
		Input.set_custom_mouse_cursor(cursorOff)
		$BurnArea/CollisionShape2D.disabled = true
		
		if timer > 0.1 and charge != max_charge:
			charge += light_charge
			timer = 0
			# Make sure the player can't spam activating the light by adding this check if charge is less than 30 
			# After holding it down and then they release it or reach 0 charge
			if charge < 30:
				can_activate_light = false
			else:
				can_activate_light = true
				
	calculate_light_size()

func calculate_light_size() -> void:
	light_size = max_size * (charge/max_charge)
