extends Node2D

@onready var burnable_area: Area2D = $BurnableArea

@export var health: int = 50:
	set(value):
		health = value
		if health == 0:
			queue_free()

func _on_burnable_area_burning() -> void:
	self.health -= 10
	print(self.health)
