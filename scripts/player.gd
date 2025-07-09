extends CharacterBody2D

@onready var player = $PlayerSprite

const SPEED = 80
const GRAVITY = 5
const JUMP_POWER = -1800
const FLOOR = Vector2(0,-1)

var acceleration = 0.1

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if GameManager.is_dead == false:
		
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			player.scale.x = 1
			player.play("walk")
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			player.scale.x = -1
			player.play("walk")
		else:
			velocity.x = 0
			player.play("idle")
			
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = JUMP_POWER * acceleration
			acceleration = acceleration + 0.1
			$sprite.play("jump")
			#$sounds/burnSound.play()
		else:
			acceleration = 0.1
		
		velocity.y += GRAVITY
		set_velocity(velocity)
		set_up_direction(FLOOR)
		move_and_slide()
		checkcollision()
		
func checkcollision()-> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is TileMapLayer:
			if collision.get_collider().get("name")=="deadzone":
				GameManager.is_dead == true
