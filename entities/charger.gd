extends CharacterBody2D

const MAX_HP = 100
const ATTACK_DAMAGE = 20
const DAMAGE = 40
const SPEED = 150
const INFECTION = 1.5

@onready var player = get_parent().get_parent().get_node("Player")
@onready var hp = MAX_HP

var chase_player = false
var canDamage = true
var canMove = true

func _physics_process(_delta: float) -> void:
	if chase_player == true and canMove:
		var playerPosition = player.position
		var targetPosition = (playerPosition - position).normalized()
		velocity = targetPosition * SPEED
		move_and_slide()


func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase_player = true


func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase_player = false

func _on_body_body_entered(body: Node2D) -> void:
	if body.name == "Player" and canDamage:
		if Game.hardModeGame:
			Game.damage(ATTACK_DAMAGE+5)
		else:
			Game.damage(ATTACK_DAMAGE)
		Game.lower_infection(INFECTION)
		explode()


func _on_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("Torpedo"):
		area.torpedo_explode()
		FxManager.play_fx(FxManager.HIT)
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
	FxManager.play_fx(FxManager.EXPLOSION)
	$CollisionShape2D.set_deferred("disabled",true)
	canDamage = false
	canMove = false
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate",Color(1,1,1,0),0.5)
	$fireFX.play("virusExplosion")


func _on_fire_fx_animation_finished() -> void:
	queue_free()
