extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $CenterContainer/AnimatedSprite2D


var animation_to_play: String = ""

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # lets this node keep working while the game is paused
	get_tree().paused = true

	if animation_to_play != "":
		animated_sprite_2d.play(animation_to_play)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
		queue_free()
