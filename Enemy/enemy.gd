extends CharacterBody2D
class_name Enemy

@export var speed: float = 150
@export var jump_height: float = -100

@onready var detection_range: Area2D = $DetectionRange
@onready var flip_direction: Node2D = $FlipDirection

var move_direction: Vector2 = Vector2.RIGHT:
	set(new_direction):
		if move_direction != new_direction:
			move_direction = new_direction
			flip_direction.scale.x = new_direction.x

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var player: Player = detection_range.player 
	if player != null:
		var direction: float = position.x - player.position.x
		if direction < 0:
			move_direction = Vector2.RIGHT
		else:
			move_direction = Vector2.LEFT
		velocity.x = speed * move_direction.x
	else:
		velocity.x = 0
	move_and_slide()
