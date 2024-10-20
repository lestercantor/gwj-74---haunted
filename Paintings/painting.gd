extends Node2D

@onready var burnable_area: Area2D = $BurnableArea
@export var burned_painting: PackedScene
var eyes: Array = []

@export var health: int = 50:
	set(value):
		health = value
		if health == 0:
			var burned = burned_painting.instantiate()
			burned.global_position = global_position
			burned.global_rotation = global_rotation
			
			get_tree().current_scene.add_child(burned)
			GlobalSignals.painting_counter.emit(-1)
			for i in eyes:
				eyes[i].disable_collision()
			queue_free()

func _ready() -> void:
	for i in get_children():
		if is_in_group("Eyes"):
			eyes.append(i)
	GlobalSignals.painting_counter.emit(1)

func _on_burnable_area_burning() -> void:
	self.health -= 5
