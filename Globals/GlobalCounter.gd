extends Node

var count: int = 0

func _ready() -> void:
	GlobalSignals.painting_counter.connect(change_counter)

func change_counter(value: int):
	count += value
	print(count)
