extends StaticBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	_check_colisions(area)

func _check_colisions(area: Area2D) -> void:
	if area.is_in_group("Torpedo"):
		area.torpedo_explode()
	elif area.is_in_group("Projectile"):
		area.projectile_explode()
