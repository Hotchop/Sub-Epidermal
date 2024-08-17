extends Area2D

const SPEED = 300

var direction: Vector2


func set_torpedo(position, targetPosition):
	global_position = position
	direction = (targetPosition - position).normalized()
	rotation_degrees = rad_to_deg(position.angle_to_point(targetPosition))

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_timer_timeout() -> void:
	queue_free()
