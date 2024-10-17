extends HSlider

@export var player: Player

func _ready() -> void:
	await player.ready
	player.mouse_light.charge_changed.connect(update)
	
	self.max_value = player.mouse_light.max_charge
	
	update()
	
func update() -> void:
	self.value = player.mouse_light.charge
	
