extends CharacterBody2D

@onready var bot = $BotSprite
@onready var enter_hint_label = $Label
@onready var bot_camera = $Camera2D
@onready var bot_access = $BotCollision/Area2D/BotAccess

@export var move_speed = 100.0
@export var jump_height: float = 10.0
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_descent: float = 0.3

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

var active_player = false


func _ready() -> void:
	enter_hint_label.visible = false
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not active_player: return
	
	if GameManager.is_dead == false:
		velocity.y += get_bot_gravity() * delta
		velocity.x = get_input_velocity() * move_speed
			
		if Input.is_action_pressed("ui_jump"):
			jump()
		
		update_animation()
		move_and_slide()
	
func get_bot_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left"):
		horizontal -= 1.0
		bot.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		horizontal += 1.0
		bot.scale.x = 1
	
	return horizontal

func jump():
	velocity.y = jump_velocity

func checkcollision()-> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is TileMapLayer:
			if collision.get_collider().get("name")=="deadzone":
				GameManager.is_dead = true

func update_animation():
	if velocity.x != 0 or velocity.y < 0:
		bot.play("move")
	else:
		bot.play("idle")

func _input(event):
	if event.is_action_pressed("ui_action") && event.is_pressed() && enter_hint_label.visible == true:
		_control_bot()
	elif active_player && event.is_action_pressed("ui_action") && event.is_pressed():
		_leave_bot()

func _control_bot():
	var player = get_tree().get_first_node_in_group("player")
	active_player = true
	player.queue_free()
	GameManager.is_mounted = true
	bot_camera.enabled = true

func _leave_bot():
	var player = preload("res://scenes/player.tscn").instantiate()
	active_player = false
	get_tree().current_scene.add_child(player)
	player.global_position = bot_access.global_position
	GameManager.is_mounted = false
	bot_camera.enabled = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		enter_hint_label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		enter_hint_label.hide()
