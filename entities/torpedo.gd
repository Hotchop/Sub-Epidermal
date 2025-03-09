extends Area2D

const SPEED = 300

var direction: Vector2

var active = true


func set_torpedo(newPosition, targetPosition):
	global_position = newPosition
	direction = (targetPosition - newPosition).normalized()
	rotation_degrees = rad_to_deg(newPosition.angle_to_point(targetPosition))

func _physics_process(delta: float) -> void:
	if active == true:
		position += direction * SPEED * delta


func _on_timer_timeout() -> void:
	torpedo_explode()

func torpedo_explode() -> void:
	active = false
	$Timer.stop()
	$Sprite2D.visible = false
	$CollisionPolygon2D.set_deferred("disabled",true)
	$GPUParticles2D.emitting = false
	$AnimatedSprite2D.play("explode")
	

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
