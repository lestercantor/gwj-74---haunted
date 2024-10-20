extends HSlider

func _ready() -> void:
	value = 0.3 - GlobalSignals.light_level
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(value: float):
	GlobalSignals.light_level = 0.3 - value
