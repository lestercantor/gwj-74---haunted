extends Area2D
class_name DetectionRange

signal monster_scream

var found: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !found:
			monster_scream.emit()
			found = true
