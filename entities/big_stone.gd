extends StaticBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Torpedo":
		area.queue_free()
		$GPUParticles2D.emitting = true
