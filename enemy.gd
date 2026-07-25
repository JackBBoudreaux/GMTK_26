extends CharacterBody2D
var speed = 180
var player_pos
var target_pos
@onready var player: CharacterBody2D = $"../../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	player_pos = player.global_position
	target_pos = (player_pos - global_position).normalized()

	if global_position.x > player_pos.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

	if global_position.distance_to(player_pos) > 3:
		global_position += target_pos * speed * delta

func _on_health_health_depleted():
	queue_free()
