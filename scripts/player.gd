extends CharacterBody2D

const SPEED = 80
const GRAVITY = 5
const JUMP_POWER = -50
const FLOOR = Vector2(0,-1)

var acceleration = 0.1
var is_dead = false

func _physics_process(delta: float) -> void:
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			$sprite.scale.x = 1
			$sprite.play("up")
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			$sprite.scale.x = -1
			$sprite.play("up")
		else:
			velocity.x = 0
			$sprite.play("idle")
			
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_POWER * acceleration
			acceleration = acceleration + 0.1
			$sprite.play("up")
			#$sounds/burnSound.play()
		else:
			acceleration = 0.1
			
		velocity.y += GRAVITY
		set_velocity(velocity)
		set_up_direction(FLOOR)
		move_and_slide()
		checkcollision()

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$sprite.play("dead")
	acceleration = 0
	$CollisionShape2D.disabled = true
	#$sounds/explosionSound.play()
	$Timer.start()
	
func checkcollision()-> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is TileMapLayer:
			if collision.get_collider().get("name")=="deadzone":
				dead()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
