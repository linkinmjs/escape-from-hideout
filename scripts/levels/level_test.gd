extends Node2D

var bot_position = Vector2(106.0, 37.0)

func _ready() -> void:
	if !GameManager.is_mounted:
		$Bot01.global_position= bot_position
	elif GameManager.is_mounted:
		$Bot01.queue_free()
	
func spawn_bot():
	pass
