extends CharacterBody2D


var speed = 280
var player_pos
var target_pos
@onready var Player: CharacterBody2D = $"../../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D





func _physics_process(delta: float) -> void:
	player_pos = Player.position
	target_pos = (player_pos - position).normalized()

	if position.distance_to(player_pos) > 3:
		position += target_pos * speed * delta


func _process(delta: float) -> void:
	if player_pos < -1:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false


func _on_health_health_depleted():
	queue_free()
