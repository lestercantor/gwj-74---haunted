extends Node2D

@onready var burnable_area: Area2D = $BurnableArea
@export var burned_painting: PackedScene

@export var health: int = 50:
	set(value):
		health = value
		if health == 0:
			var burned = burned_painting.instantiate()
			burned.global_position = global_position
			burned.global_rotation = global_rotation
			
			get_tree().current_scene.add_child(burned)
			GlobalSignals.painting_counter.emit(-1)
			GlobalSignals.painting_burned.emit()
			queue_free()

func _ready() -> void:
	GlobalSignals.painting_counter.emit(1)

func _on_burnable_area_burning() -> void:
	self.health -= 5
