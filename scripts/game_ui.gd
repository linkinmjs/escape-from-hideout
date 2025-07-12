extends CanvasLayer

var life_label:String = "Vidas: " + str(GameManager.lifes)
var level_label:String = "Nivel: " + str(LevelManager.actual_level)
var objective_label:String = "Objetivos: " + str(10) + "/" + str(10)

func _physics_process(delta: float) -> void:
	$ColorRect/HBoxContainer/lifes.text = life_label
	$ColorRect/HBoxContainer/level.text = level_label
	$ColorRect/HBoxContainer/objective.text = objective_label
