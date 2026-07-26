extends Control

@onready var main_buttons: HBoxContainer = $"Main Buttons"
@onready var credits: Panel = $Credits
@onready var noir_menu: AudioStreamPlayer = $Noir_menu

func _ready():
	main_buttons.visible = true
	credits.visible = false
	$Noir_menu.play()
func _on_START_pressed() -> void:
	$Noir_menu.stop()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
	get_tree().change_scene_to_file("res://Main.tscn")
	
func _on_SETTINGS_pressed() -> void:
	$ClickSound.play()
	print("settings pressed")

func _on_CREDITS_pressed() -> void:
	print("credits pressed")
	$ClickSound.play()
	$CreditSound.play()
	$Noir_menu.stop()
	main_buttons.visible = false
	credits.visible = true
	
func _on_X_pressed() -> void:
	$CreditSound.stop()
	main_buttons.visible = true
	credits.visible = false
	$Noir_menu.play()
	
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
