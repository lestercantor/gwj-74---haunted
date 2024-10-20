extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	
	if GlobalCounter.count > 0:
		get_tree().change_scene_to_file.call_deferred("res://Art Assets/Art Scenes/BadEndScene.tscn")
		
	else:
		get_tree().change_scene_to_file.call_deferred("res://Art Assets/Art Scenes/GoodEndScene.tscn")
