extends CanvasLayer
	
func _physics_process(delta: float) -> void:
	var life_label:String = "Vidas: " + str(GameManager.lifes)
	var level_label:String = "Nivel: " + str(LevelManager.actual_level)
	var objective_label:String = "Objetivos: " + str(10) + "/" + str(10)
	
	$ColorRect/HBoxContainer/lifes.text = life_label
	$ColorRect/HBoxContainer/level.text = level_label
	$ColorRect/HBoxContainer/objective.text = objective_label
	if !GameManager.is_mounted:
		$HBoxContainer/InactiveWeapons.visible = false

func _on_label_timer_timeout() -> void:
	var inactive_weapons_label = $HBoxContainer/InactiveWeapons
	var inactive_weapons_timer = $HBoxContainer/Label/LabelTimer
	
	if GameManager.is_mounted:
		if inactive_weapons_label.visible:
			inactive_weapons_label.visible = false
		elif !inactive_weapons_label.visible:
			inactive_weapons_label.visible = true
