extends CharacterBody2D
class_name Enemy

@export var SPEED: float = 150
@export var ACCELERATION: float = 200
@export var FRICTION: float = 300

@onready var detection_range: Area2D = $DetectionRange
@onready var flip_direction: Node2D = $FlipDirection

var move_direction: Vector2 = Vector2.RIGHT:
	set(new_direction):
		if move_direction != new_direction:
			move_direction = new_direction
			flip_direction.scale.x = new_direction.x

func _physics_process(delta: float) -> void:
	var player: Player = detection_range.player 
	if player != null:
		var direction: Vector2 = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction.normalized() * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity.y)
	move_and_slide()
