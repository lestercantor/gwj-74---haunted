extends CharacterBody2D
class_name Enemy

@export var MAX_SPEED: float = 200
@export var SPEED: float = 200
@export var ACCELERATION: float = 200
@export var FRICTION: float = 300

@onready var detection_range: Area2D = $DetectionRange
@onready var flip_direction: Node2D = $FlipDirection
@onready var animated_sprite_2d: AnimatedSprite2D = $FlipDirection/AnimatedSprite2D
@onready var burnable_area: Area2D = $BurnableArea

# Flip necessary nodes when the move direction is changed
var move_direction: Vector2 = Vector2.RIGHT:
	set(new_direction):
		if move_direction != new_direction:
			move_direction = new_direction
			flip_direction.scale.x = new_direction.x
			$EnemyCollision.position.x *= -1
			$EnemyCollision2.position.x *= -1

func _ready() -> void:
	burnable_area.burning.connect(on_burning)
	burnable_area.stopped_burning.connect(on_stopped_burning)

func _physics_process(delta: float) -> void:
	var player: Player = detection_range.player 
	if player != null:
		var direction: Vector2 = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction.normalized() * SPEED, ACCELERATION * delta)
		if direction.x < 0:
			move_direction = Vector2.LEFT
		else:
			move_direction = Vector2.RIGHT
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()

func on_burning() -> void:
	SPEED = MAX_SPEED * 0.75

func on_stopped_burning() -> void:
	SPEED = MAX_SPEED
