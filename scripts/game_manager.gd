extends Node

var is_dead = false
var is_mounted = false
var actual_level = 1

func change_level(next_level: int):
	print(is_mounted)
	actual_level = next_level
	get_tree().change_scene_to_file("res://scenes/levels/level0%d.tscn" % next_level)
