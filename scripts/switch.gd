extends Node2D

@export var unlocked_door = 0
@export var switch_number = 0
@export var is_turned_off = false

func _ready() -> void:
	print(LevelManager.switchs_turned_off)
	if LevelManager.switchs_turned_off.has(switch_number):
		is_turned_off = true
		$Sprite2D.scale.x = -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !is_turned_off:
		if body.is_in_group("player"):
			unlock_door()

func unlock_door():
	print(LevelManager.doors_blocked)
	LevelManager.doors_blocked.erase(unlocked_door)
	LevelManager.switchs_turned_off.append(switch_number)
	is_turned_off = true
	$Sprite2D.scale.x = -1
	$SoundOpen.play()
