extends Node2D

@export var TimerLength: float =  0

func _ready() -> void:
	$PointLight2D.hide()
	randomize()
	$PointLight2D/Timer.wait_time = randi_range(4,10)


func _on_timer_timeout() -> void:
	$PointLight2D.show()
	await get_tree().create_timer(0.8).timeout
	$PointLight2D.hide()
		
