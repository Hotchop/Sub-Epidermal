extends StaticBody2D

const MAX_HP = 100
const INFECTION = 10

var hp = MAX_HP

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Torpedo":
		area.queue_free()
		$GPUParticles2D.emitting = true
		hp -= 25
		if hp <= 0:
			Game.lower_infection(10)
			queue_free()
