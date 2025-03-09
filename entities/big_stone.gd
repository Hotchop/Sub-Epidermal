extends StaticBody2D


func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Torpedo"):
		FxManager.play_fx(FxManager.HIT)
		area.torpedo_explode()
		$GPUParticles2D.emitting = true
