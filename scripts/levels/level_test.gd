extends Node2D

@export var level_number = 0

var bot_position = Vector2(106.0, 37.0)

func _ready() -> void:
	LevelManager.actual_level = level_number
	if GameManager.initial_bot:
		GameManager.bot_last_level = level_number
		GameManager.bot_last_position = bot_position
		GameManager.initial_bot = false
	
	spawn_player()
	spawn_bot()

func spawn_player():
	var doors_node = get_node("Doors")
	for door in doors_node.get_children():
		if door.has_method("get_number"):
			var number = door.get_number()
			if number == LevelManager.door_spawn:
				if door.has_method("get_spawn_position"): 
					$Player.global_position = door.get_spawn_position()
					door.is_open = true

func spawn_bot():
	if GameManager.is_mounted:
		$Player.queue_free()
		var doors_node = get_node("Doors")
		for door in doors_node.get_children():
			if door.has_method("get_number"):
				var number = door.get_number()
				if number == LevelManager.door_spawn:
					if door.has_method("get_spawn_position"): $Bot01.global_position = door.get_spawn_position()
	elif !GameManager.is_mounted:
		if GameManager.bot_last_level != LevelManager.actual_level:
			$Bot01.queue_free()
		elif GameManager.bot_last_level == LevelManager.actual_level:
			$Bot01.global_position = GameManager.bot_last_position
