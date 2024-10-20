extends Area2D

@export var game_manager: GameplayManager

func _on_body_entered(body: Node2D) -> void:
	if not body is Player: return
	
	if game_manager.count > 0:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.call_deferred("res://Art Assets/Art Scenes/BadEndScene.tscn")
		
	else:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.call_deferred("res://Art Assets/Art Scenes/GoodEndScene.tscn")
