extends CanvasLayer
@export var starting_time: float = 20.0
@export var time_per_kill: float = 1.0
var time_remaining: float = 0.0
var is_running: bool = false
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	time_remaining = starting_time
	is_running = false
	visible = false  # hidden until gameplay actually starts
	_update_label()

	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)

func start_countdown() -> void:
	is_running = true
	visible = true
	timer.start()

func reset() -> void:
	time_remaining = starting_time
	is_running = true
	visible = true
	timer.start()
	_update_label()

func _on_timer_timeout() -> void:
	if not is_running:
		return
	time_remaining -= 1.0
	if time_remaining <= 0:
		time_remaining = 0
		is_running = false
		_update_label()
		GameOverManager.trigger_game_over("bomb_death")
		return
	_update_label()

func add_time(seconds: float) -> void:
	if not is_running:
		return
	time_remaining += seconds
	_update_label()

func _update_label() -> void:
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	label.text = "%d:%02d" % [minutes, seconds]
