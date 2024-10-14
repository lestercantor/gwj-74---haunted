extends ParallaxLayer


export(float) var CloudSpeed = -15



func _process(delta) -> void:
	self.motion_offset.x += CloudSpeed
