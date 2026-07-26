extends Node

const GAME_OVER_SCENE: PackedScene = preload("res://game_over.tscn")

func trigger_game_over(reason: String) -> void:
	get_tree().paused = false
	var game_over_instance = GAME_OVER_SCENE.instantiate()
	var game_over_control = game_over_instance.get_node("GameOver")
	game_over_control.animation_to_play = reason
	get_tree().root.add_child(game_over_instance)
