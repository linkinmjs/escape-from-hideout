extends Node2D

@export var level = 0

func _ready() -> void:
	spawn_player()
	LevelManager.actual_level = level
	print("print desde level: %d" %level)

func spawn_player():
	var doors_node = get_node("Doors")
	for door in doors_node.get_children():
		if door.has_method("get_number"):
			var number = door.get_number()
			if number == LevelManager.door_spawn:
				if GameManager.is_mounted:
					var player_scene = preload("res://scenes/bot01.tscn")
					var player = player_scene.instantiate()
					player.position = door.get_spawn_position()
					doors_node.add_sibling(player)
				else:
					var player_scene = preload("res://scenes/player.tscn")
					var player = player_scene.instantiate()
					player.position = door.get_spawn_position()
					doors_node.add_sibling(player)
