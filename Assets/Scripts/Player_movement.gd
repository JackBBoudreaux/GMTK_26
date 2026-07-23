extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


#player basic movement
const MAX_SPEED: int = 250
const ACCELERATION: int = 1400
const FRICTION: int = 1000

#player dodge
const DODGE_SPEED: float = 400.0
const DODGE_DURATION: float = 0.3

#dodge roll stuff
var dodge_roll_dir: Vector2 = Vector2. ZERO
var dodge_roll_timer: float = 0.0

var can_take_damage: bool = true

 
func _physics_process(_delta: float) -> void:
	if velocity.x > 1 or velocity.x < -1 or velocity.y > 0 or velocity.y < -1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"


 

 #flips player sprite 
func _process(delta: float) -> void:
	if get_global_mouse_position().x < global_position.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
 
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, ACCELERATION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, FRICTION * delta)	
	move_and_slide()
