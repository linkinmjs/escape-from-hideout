extends Node

@onready var player = self.owner

@export var move_speed = 100.0
@export var jump_height: float = 50.0
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

enum STATE {
	IDLE,
	RUNNING,
	JUMPING,
}

var current_state:STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	match current_state:
		STATE.IDLE:
			player.velocity.x = 0
			player.play_animation(player.animation.)
		STATE.RUNNING:
			pass
		STATE.JUMPING:
			pass
