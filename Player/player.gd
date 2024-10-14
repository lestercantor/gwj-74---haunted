extends CharacterBody2D
class_name Player

const SPEED: float = 200.0
const JUMP_VELOCITY: float = -300.0

@onready var death_area_2d: Area2D = $DeathArea2D

func _ready() -> void:
	# Connect to signal from Area2D node when player death area has overlapped with the enemy
	death_area_2d.body_entered.connect(enemy_collision)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# Call function when player has collided with enemy
func enemy_collision(enemy: Enemy) -> void:
	print("player got killed by enemy")
