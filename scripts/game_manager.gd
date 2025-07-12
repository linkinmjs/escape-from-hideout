extends Node

var is_dead = false
var is_mounted = false
var lifes = 3

var bot_ui_action_disabled = false
var initial_bot = true
var bot_last_position = Vector2()
var bot_last_level = 0

func lost_life():
	lifes =- 1
	if lifes == 0:
		LevelManager.game_over()
