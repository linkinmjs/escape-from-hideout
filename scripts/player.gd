extends CharacterBody2D

@onready var player = $PlayerSprite

@export var move_speed = 100.0
@export var jump_height: float = 50.0
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta):
	if GameManager.is_dead == false:
		velocity.y += get_player_gravity() * delta
		velocity.x = get_input_velocity() * move_speed
		
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			jump()
		
		update_animation()
		move_and_slide()

func get_player_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left"):
		horizontal -= 1.0
		player.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		horizontal += 1.0
		player.scale.x = 1
	
	return horizontal

func update_animation():
	if not is_on_floor():
		player.play("jump")
	elif velocity.x != 0:
		player.play("walk")
	else:
		player.play("idle")
