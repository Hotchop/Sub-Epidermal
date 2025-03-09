extends StaticBody2D


func _on_area_1_area_entered(area: Area2D) -> void:
	_check_colisions(area)


func _on_area_2_area_entered(area: Area2D) -> void:
	_check_colisions(area)


func _on_area_3_area_entered(area: Area2D) -> void:
	_check_colisions(area)


func _on_area_4_area_entered(area: Area2D) -> void:
	_check_colisions(area)

func _check_colisions(area: Area2D) -> void:
	if area.is_in_group("Torpedo"):
		area.torpedo_explode()
	elif area.is_in_group("Projectile"):
		area.projectile_explode()
