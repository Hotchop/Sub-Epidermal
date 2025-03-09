extends Area2D

const SPEED = 200

var direction: Vector2

var active = true

func _process(delta: float) -> void:
	$Sprite2D.rotation += delta

func set_proyectile(newPosition, targetPosition):
	global_position = newPosition
	direction = (targetPosition - newPosition).normalized()
	rotation_degrees = rad_to_deg(newPosition.angle_to_point(targetPosition))

func set_by_angle(newPosition,angle):
	global_position = newPosition
	direction = Vector2.from_angle(deg_to_rad(angle))
	

func _physics_process(delta: float) -> void:
	if active == true:
		position += direction * SPEED * delta


func _on_timer_timeout() -> void:
	projectile_explode()

func projectile_explode() -> void:
	active = false
	$Timer.stop()
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimatedSprite2D.play("explode")


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
