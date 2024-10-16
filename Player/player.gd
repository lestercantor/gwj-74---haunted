extends CharacterBody2D
class_name Player

const SPEED: float = 200.0
const JUMP_VELOCITY: float = -500.0


@onready var animated_Sprite = $AnimatedSprite2D	

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
	handle_movement_animation(direction)
	
# Call function when player has collided with enemy
func enemy_collision(enemy: Enemy) -> void:
	if not enemy is Enemy: return
	print("player got killed by enemy")
	
	
func handle_movement_animation(direction):
		if !velocity.x:
			animated_Sprite.play("Idle")
		if velocity.x:
			animated_Sprite.play("Walk")
			toggle_flip_sprite(direction)
		if !is_on_floor():
			animated_Sprite.play("Jump")

			
func toggle_flip_sprite(direction):
	if direction == 1:
		animated_Sprite.flip_h = false
	if direction == -1:
		animated_Sprite.flip_h = true
