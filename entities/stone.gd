extends StaticBody2D

const MAX_HP = 100
const INFECTION = 10

var hp = MAX_HP

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Torpedo") or area.is_in_group("Projectile"):
		if area.is_in_group("Projectile"):
			area.projectile_explode()
			FxManager.play_fx(FxManager.HIT)
			$GPUParticles2D.emitting = true
		else:
			area.torpedo_explode()
			FxManager.play_fx(FxManager.HIT)
			$GPUParticles2D.emitting = true
			hp -= 25
		if hp <= 0:
			FxManager.play_fx(FxManager.ROCKS)
			Game.lower_infection(10)
			$CollisionPolygon2D.set_deferred("disabled",true)
			$Area2D/CollisionPolygon2D2.set_deferred("disabled",true)
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D,"modulate",Color(1, 1, 1, 0),1)
			$Cracks.emitting = true
			await get_tree().create_timer(1).timeout
			queue_free()
