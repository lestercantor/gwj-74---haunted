extends Area2D

signal burning
signal stopped_burning

var timer: float = 0.5
var is_burning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_burning:
		timer += delta
		
		if timer > 1:
			timer = 0
			burning.emit()

func _on_area_entered(area: Area2D) -> void:
	is_burning = true
	timer = 0.5


func _on_area_exited(area: Area2D) -> void:
	is_burning = false
	timer = 0.5
	stopped_burning.emit()
