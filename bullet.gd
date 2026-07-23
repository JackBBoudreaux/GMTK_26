extends Node2D

const SPEED: int = 300
 
 #how the bullet shoots
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
 #when the bullet exits the screen it gets deleted from memory
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
