extends Control



	
@onready var main_buttons: HBoxContainer = $"Main Buttons"
@onready var credits: Panel = $Credits

#

func _ready():
	main_buttons.visible = true
	credits.visible = false

func _on_START_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
	
func _on_SETTINGS_pressed() -> void:
	print("settings pressed")

func _on_CREDITS_pressed() -> void:
	print("credits pressed")
	main_buttons.visible = false
	credits.visible = true
	
func _on_X_pressed() -> void:
	main_buttons.visible = true
	credits.visible = false
	
func _on_EXIT_pressed() -> void:
	get_tree().quit()
