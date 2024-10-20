extends Area2D
class_name DetectionRange

var found: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		found = true
