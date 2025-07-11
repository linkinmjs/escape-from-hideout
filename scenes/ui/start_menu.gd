extends Control

func _ready() -> void:
	$sounds/theme.play()


func _on_start_pressed() -> void:
	$sounds/select.play()
	get_tree().change_scene_to_file("res://scenes/levels/level01.tscn")
func _on_options_pressed() -> void:
	$sounds/select.play()
func _on_exit_pressed() -> void:
	$sounds/select.play()
	get_tree().quit()

func _on_start_mouse_entered() -> void:
	$sounds/hover_button.play()
func _on_options_mouse_entered() -> void:
	$sounds/hover_button.play()
func _on_exit_mouse_entered() -> void:
	$sounds/hover_button.play()
