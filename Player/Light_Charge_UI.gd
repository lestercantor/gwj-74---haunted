extends ProgressBar

@export var player: Player

func _ready() -> void:
	GlobalSignals.charge_changed.connect(update)
	
func update() -> void:
	value = player.mouse_light.charge
