extends Node2D


const SPEED: int = 1000
 
 #how the bullet shoots
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
 #when the bullet exits the screen it gets deleted from memory
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
		queue_free()
