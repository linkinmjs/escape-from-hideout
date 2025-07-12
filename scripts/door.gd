extends Node2D

@export var send_to_level = 0
@export var send_to_door = 0
@export var is_blocked = true
@export var is_open = false
@export var is_big_door = false
@export var number = 0

@onready var door = $DoorSprite
@onready var label = $Label

var player_close = false

func _ready() -> void:
	label.visible = false
	if is_open or !LevelManager.doors_blocked.has(number):
		door.play("open")

func _physics_process(delta: float) -> void:

	if !LevelManager.doors_blocked.has(number):
		is_blocked = false
	
	if player_close:
		if !is_blocked && !is_open:
			label.show()
			if Input.is_action_just_pressed("ui_action"):
				door.play("opening")
				is_open = true
				label.hide()
		elif is_open:
			if Input.is_action_just_pressed("ui_action"):
				label.hide()
					
				LevelManager.door_spawn = send_to_door
				LevelManager.change_level(send_to_level)
	else:
		label.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("bot"):
		if is_big_door and GameManager.is_mounted:
			player_close = true
			GameManager.bot_ui_action_disabled = true
		elif !is_big_door and !GameManager.is_mounted:
			player_close = true	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("bot"):
		if is_big_door and GameManager.is_mounted:
			player_close = false
			GameManager.bot_ui_action_disabled = false
		elif !is_big_door and !GameManager.is_mounted:
			player_close = false

func get_number() -> int:
	return number

func unlock():
	is_blocked = false
	
func open():
	door.play("opening")
	is_open = true
	
func get_spawn_position() -> Vector2:
	return $Spawn.global_position
