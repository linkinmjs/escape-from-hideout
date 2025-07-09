extends Node2D

@export var is_next_level_door = true
@export var is_bloqued = false
@export var is_open = false
@export var player_is_close = false
@export var level_door = 2

@onready var door = $DoorSprite
@onready var label = $Label

func _ready() -> void:
	label.visible = false
	if is_open:
		door.frame = 5

func _physics_process(delta: float) -> void:
	
	if player_is_close:
		if is_open == false:
			label.show()
			if Input.is_action_just_pressed("ui_action"):
				door.play("opening")
				is_open = true
				label.hide()
		elif is_open == true:
			if Input.is_action_just_pressed("ui_action"):
				label.hide()
	else:
		label.hide()

func open():
	door.play("opening")
	is_open = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_close = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_close = false
