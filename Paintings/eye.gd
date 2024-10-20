extends Sprite2D

@onready var pupil: Sprite2D = $Pupil

@export var max_distance = 4.5
var player_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	GlobalSignals.player_position.connect(track_player)
	
func _process(_delta: float) -> void:
	var direction = global_position.direction_to(player_position)
	var distance = player_position.length()
	
	pupil.position = direction * min(distance, max_distance)

func track_player(player_pos: Vector2):
	player_position = player_pos
