extends CharacterBody2D

var speed = 180
var player_pos
var target_pos

@export var attack_cooldown: float = 1.0

var can_attack: bool = true
var is_attacking: bool = false
var player_in_range: bool = false

var animation_offsets := {
	"enemy_running": Vector2(0, 0),
	"enemy_attacking": Vector2(-4, -2),
}

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var attack_area: Area2D = $AttackArea
@onready var hit_box: HitBox = $"../HitBox"


func _ready() -> void:
	if player == null:
		push_error("Enemy could not find a node in the 'player' group!")

	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)

	animated_sprite_2d.animation_finished.connect(_on_animation_finished)
	animated_sprite_2d.frame_changed.connect(_on_frame_changed)

	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)

	hit_box.monitoring = false  # off by default, only enabled during the attack swing

func _physics_process(delta: float) -> void:
	if player == null:
		return

	player_pos = player.global_position
	target_pos = (player_pos - global_position).normalized()
	animated_sprite_2d.flip_h = global_position.x > player_pos.x

	if is_attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if player_in_range:
		velocity = Vector2.ZERO
		move_and_slide()
		if can_attack:
			_start_attack()
	else:
		velocity = target_pos * speed
		move_and_slide()
		_play_animation("enemy_running")

func _play_animation(anim_name: String) -> void:
	if animated_sprite_2d.animation != anim_name:
		animated_sprite_2d.play(anim_name)
	var offset = animation_offsets.get(anim_name, Vector2.ZERO)
	if animated_sprite_2d.flip_h:
		animated_sprite_2d.position = Vector2(-offset.x, offset.y)
	else:
		animated_sprite_2d.position = offset

func _on_attack_area_body_entered(body: Node) -> void:
	if body == player:
		player_in_range = true

func _on_attack_area_body_exited(body: Node) -> void:
	if body == player:
		player_in_range = false

func _start_attack() -> void:
	is_attacking = true
	can_attack = false
	_play_animation("enemy_attacking")
	attack_timer.start()

func _on_frame_changed() -> void:
	if animated_sprite_2d.animation != "enemy_attacking":
		return
	# Turn the hitbox on only during the "impact" frame(s) — adjust this
	# number to match whichever frame the weapon/claw actually connects
	if animated_sprite_2d.frame == 9:
		hit_box.monitoring = true
	else:
		hit_box.monitoring = false

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "enemy_attacking":
		is_attacking = false
		hit_box.monitoring = false  # safety net

func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_health_health_depleted() -> void:
	if is_attacking:
		is_attacking = false
	set_physics_process(false)  # stop all movement/attack logic immediately
	velocity = Vector2.ZERO
	hit_box.monitoring = false
	attack_area.monitoring = false  # stop it from re-triggering attacks while dying

	animated_sprite_2d.play("enemy_death")
	animated_sprite_2d.animation_finished.connect(_on_death_animation_finished)

func _on_death_animation_finished() -> void:
	if animated_sprite_2d.animation == "enemy_death":
		queue_free()
