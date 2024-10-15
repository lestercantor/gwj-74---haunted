extends Area2D
class_name DetectionRange

var player: Player = null

func can_see_player() -> bool:
	return player != null
	
func _on_body_entered(body: Node2D) -> void:
	player = body

func _on_body_exited(_body: Node2D) -> void:
	player = null
