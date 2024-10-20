extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $SightArea/CollisionShape2D
@onready var animation: AnimationPlayer = $SightArea/AnimationPlayer
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.painting_burned.connect(disable_collision)

func disable_collision() -> void:
	collision_shape_2d.disabled = true
	timer.stop()
	$SightArea/EyeWhite.frame = 1
	$SightArea/EyeWhite/Pupil.visible = false
	
func random_blink() -> void:
	if random_number():
		animation.play("blink")
	else:
		animation.play("random_blink")

func random_number() -> bool:
	var random: float = randf_range(0,1)
	if random > 0.7:
		return true
	else:
		return false
