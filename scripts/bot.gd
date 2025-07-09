extends CharacterBody2D

@onready var bot = $BotSprite
@onready var enter_hint_label = $Label
@onready var camera = $Camera2D

const SPEED = 80
const GRAVITY = 5
const JUMP_POWER = -50
const FLOOR = Vector2(0,-1)

var acceleration = 0.1
var active_player = false

func _ready() -> void:
	enter_hint_label.visible = false

func _physics_process(delta: float) -> void:
	if not active_player: return
	
	if GameManager.is_dead == false:
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			bot.scale.x = 1
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			bot.scale.x = -1
		else:
			velocity.x = 0
			
		if Input.is_action_pressed("ui_jump"):
			velocity.y = JUMP_POWER * acceleration
			acceleration = acceleration + 0.1
			#$sounds/burnSound.play()
		else:
			acceleration = 0.1
			
		velocity.y += GRAVITY
		set_velocity(velocity)
		set_up_direction(FLOOR)
		move_and_slide()
		checkcollision()
		update_animation()
	
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
	camera.enabled = true

func _leave_bot():
	var player = preload("res://scenes/player.tscn").instantiate()
	active_player = false
	get_tree().current_scene.add_child(player)
	player.global_position = global_position
	camera.enabled = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		enter_hint_label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		enter_hint_label.hide()
