extends CharacterBody2D

const SPEED = 200
const ACCELERATION = 5

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up","ui_down")
	if direction_x == -1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction_x == 1:
		get_node("AnimatedSprite2D").flip_h = true
	if direction_x:
		velocity.x = move_toward(velocity.x, direction_x*SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
	if direction_y:
		velocity.y = move_toward(velocity.y, direction_y*SPEED, ACCELERATION)
	else:
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	move_and_slide()
