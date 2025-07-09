extends Node2D

@export var send_to_level = 0
@export var is_bloqued = false
@export var is_open = false

@onready var door = $DoorSprite
@onready var label = $Label

var player_close = false
var mounted_on_bot = GameManager.is_mounted

func _ready() -> void:
	label.visible = false
	if is_open:
		door.frame = 5

func _physics_process(delta: float) -> void:
	
	if player_close:
		if is_open == false:
			label.show()
			if Input.is_action_just_pressed("ui_action"):
				door.play("opening")
				is_open = true
				label.hide()
		elif is_open == true:
			if Input.is_action_just_pressed("ui_action"):
				label.hide()
				GameManager.change_level(send_to_level)
	else:
		label.hide()

func open():
	door.play("opening")
	is_open = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_close = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_close = false
