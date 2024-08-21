extends CharacterBody2D

const MAX_HP = 100
const ATTACK_DAMAGE = 10
const DAMAGE = 40
const INFECTION = 1.5

@onready var preloadProyectile = preload("res://entities/proyectile.tscn")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var hp = MAX_HP

var active = true
var canShoot = false
var isShooting = false

func _process(delta: float) -> void:
	$AnimatedSprite2D.rotation += delta
	
func _physics_process(_delta: float) -> void:
	if canShoot:
		_shoot()

func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player" and active:
		canShoot = true
		
func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player" and active:
		canShoot = false

func _shoot():
		if isShooting: return
		
		isShooting = true
		var targetPosition = player.position
		var _shootDirection = (targetPosition - global_position).normalized()
		
		var proyectile = preloadProyectile.instantiate()
		var spawnPosition = global_position
		spawnPosition.y +=10
		proyectile.set_proyectile(spawnPosition,targetPosition)
		FxManager.play_fx(FxManager.TORPEDO)
		get_parent().add_child(proyectile)
		
		await get_tree().create_timer(2).timeout
		
		isShooting = false

func _on_body_area_entered(area: Area2D) -> void:
	if area.name == "Torpedo":
		FxManager.play_fx(FxManager.HIT)
		area.queue_free()
		get_hit(DAMAGE)


func get_hit(value):
	if Game.hardModeGame:
		hp -= value-10
	else:
		hp -= value
	if hp <= 0:
		Game.lower_infection(INFECTION)
		explode()
		
		
func explode():
	active = false
	canShoot = false
	FxManager.play_fx(FxManager.EXPLOSION)
	$CollisionShape2D.set_deferred("disabled",true)
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate",Color(1,1,1,0),0.5)
	$fireFX.play("virusExplosion")


func _on_fire_fx_animation_finished() -> void:
	queue_free()
