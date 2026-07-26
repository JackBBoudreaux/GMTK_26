extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Node2D = $Gun


const MAX_SPEED: int = 250
const ACCELERATION: int = 1400
const FRICTION: int = 1000

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	#if player is moving causes run animation to play. idle if idle
	if velocity.x > 1 or velocity.x < -1 or velocity.y > 0 or velocity.y < -1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"

func _process(delta: float) -> void:
	if is_dead:
		return

	#causes the sprite to flip towards the cursor
	if get_global_mouse_position().x < global_position.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

	#player movement
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, ACCELERATION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, FRICTION * delta)
	move_and_slide()



#player dying function
func _on_health_health_depleted() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	gun.visible = false
	animated_sprite_2d.play("dying")
	animated_sprite_2d.animation_finished.connect(_on_death_animation_finished)

#reload scene after death. Put Game Over in this or whatever
func _on_death_animation_finished() -> void:
	if animated_sprite_2d.animation == "dying":
		get_tree().reload_current_scene()
