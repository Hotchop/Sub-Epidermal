extends Area2D

const SPEED = 250

var direction: Vector2

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
	position += direction * SPEED * delta


func _on_timer_timeout() -> void:
	queue_free()
