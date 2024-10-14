extends ParallaxLayer


@export var CloudSpeedx: float =  0
@export var CloudSpeedy: float =  0




func _process(delta) -> void:
	self.motion_offset.x += CloudSpeedx
	self.motion_offset.y += CloudSpeedy
