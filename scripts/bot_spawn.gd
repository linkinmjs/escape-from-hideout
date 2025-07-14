extends Node2D

func _ready() -> void:
	spawn_bot()

func spawn_bot():
	if GameManager.initial_bot:
		GameManager.initial_bot = false
		var bot_scene = preload("res://scenes/bot01.tscn")
		var bot = bot_scene.instantiate()
		add_sibling.call_deferred(bot)
		bot.position = position
	elif !GameManager.initial_bot && !GameManager.is_mounted:
		var bot_scene = preload("res://scenes/bot01.tscn")
		var bot = bot_scene.instantiate()
		bot.global_position = GameManager.bot_last_position
		print(GameManager.bot_last_position)
		add_sibling.call_deferred(bot)


func _on_player_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
