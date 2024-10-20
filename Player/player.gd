extends CharacterBody2D
class_name Player

@export var SPEED: float = 200.0
@export var MAX_SPEED: float = 200.0
@export var JUMP_VELOCITY: float = -510.0

var cursor = preload("res://Art Assets/UI/MatchstickOff.png")

@onready var animated_Sprite = $AnimatedSprite2D
@onready var mouse_light: MouseLight = $MouseLight
@onready var death_area_2d: Area2D = $DeathArea2D

var death: bool = false

func _ready() -> void:
	# Connect to signal from Area2D node when player death area has overlapped with the enemy
	death_area_2d.body_entered.connect(enemy_collision)
	death_area_2d.area_entered.connect(inside_eye_collision)
	death_area_2d.area_exited.connect(outside_eye_collision)
	Input.set_custom_mouse_cursor(cursor)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !death:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction: float = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		handle_movement_animation(direction)
		GlobalSignals.player_position.emit(global_position)
	move_and_slide()
# Call function when player has collided with enemy
func enemy_collision(enemy: Enemy) -> void:
	if not enemy is Enemy: return
	player_death()
	
# Call function when player is within range of death area
func inside_eye_collision(_area: Area2D) -> void:
	SPEED = MAX_SPEED * 0.85
	
func outside_eye_collision(_area: Area2D) -> void:
	SPEED = MAX_SPEED
	
func handle_movement_animation(direction) -> void:
	if !death:
		if !velocity.x:
			animated_Sprite.play("Idle")
		if velocity.x:
			animated_Sprite.play("Walk")
			toggle_flip_sprite(direction)
		if !is_on_floor():
			animated_Sprite.play("Jump")
			
func toggle_flip_sprite(direction) -> void:
	animated_Sprite.flip_h = direction < 0 

func player_death() -> void:
	print("player died")
	death = true
	mouse_light.set_process_mode(4)
	animated_Sprite.play("Death")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Art Assets/Art Scenes/BadEndScene.tscn")
