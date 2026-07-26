extends CharacterBody2D

@export var speed: float = 150.0
@export var min_wander_time: float = 1.0
@export var max_wander_time: float = 3.0

var direction: Vector2 = Vector2.ZERO
var is_dead: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wander_timer: Timer = $WanderTimer

func _ready() -> void:
	wander_timer.timeout.connect(_on_wander_timer_timeout)
	_pick_new_direction()

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	velocity = direction * speed
	move_and_slide()

	animated_sprite_2d.flip_h = direction.x < 0

	if direction.length() > 0.1:
		if animated_sprite_2d.animation != "civilian_running":
			animated_sprite_2d.play("civilian_running")
	else:
		if animated_sprite_2d.animation != "civilian_idle":
			animated_sprite_2d.play("civilian_idle")

func _pick_new_direction() -> void:
	var angle = randf_range(0, TAU)
	direction = Vector2(cos(angle), sin(angle))

	wander_timer.wait_time = randf_range(min_wander_time, max_wander_time)
	wander_timer.start()

func _on_wander_timer_timeout() -> void:
	_pick_new_direction()

func _on_health_health_depleted() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite_2d.play("civilian_death")
	animated_sprite_2d.animation_finished.connect(_on_death_animation_finished)

func _on_death_animation_finished() -> void:
	if animated_sprite_2d.animation == "civilian_death":
		queue_free()
