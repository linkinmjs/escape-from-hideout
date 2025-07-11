extends Node

var actual_level = 1
var door_spawn = 0
var doors_blocked = [2, 4, 6, 8]
var doors_opened = [2, 4, 6, 8]

var player_spawn_position = Vector2()

func change_level(new_level: int):
	actual_level = new_level
	get_tree().change_scene_to_file("res://scenes/levels/levelTest0%d.tscn" % new_level)

func check_doors_blocked():
	var doors_node = get_node("Doors")
	for door in doors_node.get_children():
		if door.has_method("get_number"):
			var number = door.get_number()
			if not doors_blocked.has(number):
				if door.has_method("unlock"):
					door.unlock()
