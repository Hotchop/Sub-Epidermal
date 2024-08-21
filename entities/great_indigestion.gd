extends CharacterBody2D

const MAX_HP = 100
const ATTACK_DAMAGE = 20
const DAMAGE = 3
const SPEED = 400

signal boss_death()

@onready var preloadProyectile = preload("res://entities/boss_projectile.tscn")

@onready var player = get_parent().get_node("Player")
@onready var hp = MAX_HP

@export var canDamage = true
@export var canMove = true
@export var canShoot = true


func _ready() -> void:
	$Roar.volume_db = FxManager.fxVolume
	$Lunge.volume_db = FxManager.fxVolume
	$Hit.volume_db = FxManager.fxVolume
	$Explosion.volume_db = FxManager.fxVolume

func _process(delta: float) -> void:
	$AnimatedSprite2D.rotation += delta*0.5


func _physics_process(_delta: float) -> void:
	#var playerPosition = player.position
	#var targetPosition = (playerPosition - position).normalized()
	#velocity = targetPosition * SPEED
	if canMove == false:
		velocity = Vector2(0,0)
	move_and_slide()


func _lunge():
	if canMove:
		var amount
		var jump_speed
		if hp <= 50:
			amount = 4
			jump_speed = SPEED + 100
		else:
			amount = 3
			jump_speed = SPEED
		for n in amount:
			var playerPosition = player.position
			var targetPosition = (playerPosition - position).normalized()
			velocity = targetPosition * jump_speed
			$Lunge.play()
			await get_tree().create_timer(2).timeout
			velocity = Vector2(0,0)
			await get_tree().create_timer(1).timeout
		_shoot()

func _shoot():
	if canShoot:
		var startingDegree = 0
		var amount
		var awaitTime
		if hp <= 50:
			amount = 2
			awaitTime = 1
		else:
			amount = 1
			awaitTime = 0.5
		$Roar.play()
		for n in amount:
			var spawnPosition = global_position
			var proyectile1 = preloadProyectile.instantiate()
			var proyectile2 = preloadProyectile.instantiate()
			var proyectile3 = preloadProyectile.instantiate()
			var proyectile4 = preloadProyectile.instantiate()
			var proyectile5 = preloadProyectile.instantiate()
			var proyectile6 = preloadProyectile.instantiate()
			
			proyectile1.set_by_angle(spawnPosition,startingDegree)
			proyectile2.set_by_angle(spawnPosition,startingDegree+60)
			proyectile3.set_by_angle(spawnPosition,startingDegree+120)
			proyectile4.set_by_angle(spawnPosition,startingDegree+180)
			proyectile5.set_by_angle(spawnPosition,startingDegree+240)
			proyectile6.set_by_angle(spawnPosition,startingDegree+300)
			
			
			get_parent().add_child(proyectile1)
			get_parent().add_child(proyectile2)
			get_parent().add_child(proyectile3)
			get_parent().add_child(proyectile4)
			get_parent().add_child(proyectile5)
			get_parent().add_child(proyectile6)
			
			FxManager.play_fx(FxManager.TORPEDO)
			startingDegree += 30
			await get_tree().create_timer(awaitTime).timeout
			awaitTime -= 0.5
		$Timer.start()


func _on_timer_timeout() -> void:
	_lunge()


func _on_body_body_entered(body: Node2D) -> void:
	if body.name == "Player" and canDamage:
		if Game.hardModeGame:
			Game.damage(ATTACK_DAMAGE+5)
		else:
			Game.damage(ATTACK_DAMAGE)


func _on_body_area_entered(area: Area2D) -> void:
	if area.name == "Torpedo":
		$Hit.play()
		area.queue_free()
		get_hit(DAMAGE)


func get_hit(value):
	if Game.hardModeGame:
		hp -= value-1
	else:
		hp -= value
	if hp <= 0:
		$Timer.stop()
		canDamage = false
		canMove = false
		canShoot = false
		$fireFX.play("bossExplosion")
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite2D,"modulate",Color(1,1,1,0),5)
		await get_tree().create_timer(7).timeout
		boss_death.emit()
		queue_free()


func _on_fire_fx_animation_looped() -> void:
	$Explosion.play()
