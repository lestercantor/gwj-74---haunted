extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $SightArea/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.painting_burned.connect(disable_collision)

func disable_collision() -> void:
	collision_shape_2d.disabled = true
