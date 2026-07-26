extends Control



	
@onready var main_buttons: HBoxContainer = $"Main Buttons"
@onready var credits: Panel = $Credits

#

func _ready():
	main_buttons.visible = true
	credits.visible = false

func _on_START_pressed() -> void:
	$StartButtonSound.play()
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://Main.tscn")
	
func _on_SETTINGS_pressed() -> void:
	$ClickSound.play()
	print("settings pressed")

func _on_CREDITS_pressed() -> void:
	print("credits pressed")
	$ClickSound.play()
	$CreditSound.play()
	main_buttons.visible = false
	credits.visible = true
	
func _on_X_pressed() -> void:
	$CreditSound.stop()
	main_buttons.visible = true
	credits.visible = false
	
func _on_EXIT_pressed() -> void:
	$ClickSound.play()
	get_tree().quit()

func _on_START_mouse_entered() -> void:
	$HoverSound.play()

func _on_SETTINGS_mouse_entered() -> void:
	$HoverSound.play()

func _on_CREDITS_mouse_entered() -> void:
	$HoverSound.play()


func _on_EXIT_mouse_entered() -> void:
	$HoverSound.play()
