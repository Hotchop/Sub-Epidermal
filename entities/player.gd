extends CharacterBody2D

const SPEED = 200
const ACCELERATION = 5

@export var canMove = true
@export var canShoot = true
var preloadTorpedo = preload("res://entities/torpedo.tscn")
var isShooting = false
var targetPosition: Vector2
var shootDirection: Vector2

func _physics_process(_delta: float) -> void:
	if canMove == true:
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
	if canShoot:
		_shoot()


func _shoot():
	if Input.is_action_pressed("ui_left_click"):
		if isShooting: return
		
		isShooting = true
		targetPosition = get_global_mouse_position()
		shootDirection = (targetPosition - global_position).normalized()
		
		var torpedo = preloadTorpedo.instantiate()
		var spawnPosition = global_position
		spawnPosition.y +=10
		torpedo.set_torpedo(spawnPosition,targetPosition)
		get_parent().add_child(torpedo)
		
		await get_tree().create_timer(1).timeout
		
		isShooting = false

func explode():
	self.canMove = false
	self.canShoot = false
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate",Color(1,1,1,0),0.5)
	$fireFX.play("subExplosion")


func _on_fire_fx_animation_finished() -> void:
	self.visible = false
