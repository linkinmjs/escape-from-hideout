extends Node2D

@export var is_next_level_door = true
@export var is_bloqued = false
@export var is_open = false
@export var level_door = 2

@onready var door = $DoorSprite
@onready var label = $Label

func _ready() -> void:
	label.visible = false
	if is_open:
		door.frame = 5
		
func open():
	door.play("opening")

func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	print(player)
	label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	label.hide()
