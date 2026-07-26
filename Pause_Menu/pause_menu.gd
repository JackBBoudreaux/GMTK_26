extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_pause_menu"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
		
func _on_RESUME_pressed() -> void:
	$ClickSound.play()
	visible = false
	get_tree().paused = false

func _on_button_2_pressed() -> void:
	
	get_tree().change_scene_to_file("res://main_menu.tscn")
	$ClickSound.play()

func _on_resume_mouse_entered() -> void:
	$HoverSound.play()

func _on_exit_mouse_entered() -> void:
	$HoverSound.play()
