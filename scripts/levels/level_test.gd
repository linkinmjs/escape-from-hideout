extends Node2D

var bot_position = Vector2(106.0, 37.0)

func _ready() -> void:
	spawn_player()
	spawn_bot()

func spawn_player():
	var doors_node = get_node("Doors")
	for door in doors_node.get_children():
		if door.has_method("get_number"):
			var number = door.get_number()
			print("Door number: %d" % number) 
			if number == LevelManager.door_spawn:
				if door.has_method("get_spawn_position"): $Player.global_position = door.get_spawn_position()

func spawn_bot():
	pass
