extends HSlider

func _ready() -> void:
	value = GlobalSignals.light_level
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(value: float):
	GlobalSignals.light_level = value
