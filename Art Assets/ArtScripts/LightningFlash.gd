extends Node2D

@export var TimerLength: float =  0

func _ready() -> void:
	$Sprite2D.hide()
	randomize()
	$Sprite2D/Timer.wait_time = randi_range(4,10)


func _on_timer_timeout() -> void:
	$Sprite2D.show()
	await get_tree().create_timer(0.1,0.3).timeout
	$Sprite2D.hide()
		
