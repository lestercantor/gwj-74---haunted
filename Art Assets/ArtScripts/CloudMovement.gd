extends ParallaxLayer


@export var CloudSpeed: float = -0.01



func _process(delta) -> void:
	self.motion_offset.x += CloudSpeed
