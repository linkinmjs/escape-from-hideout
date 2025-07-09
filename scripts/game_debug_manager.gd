extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F1:
			print(event.is_action_pressed("ui_action"))
