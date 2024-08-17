extends CharacterBody2D

const MAX_HP = 100
const ATTACK_DAMAGE = 20
const DAMAGE = 40
const SPEED = 150
const INFECTION = 2

@onready var player = get_parent().get_parent().get_node("Player")
@onready var hp = MAX_HP

var chase_player = false

func _physics_process(_delta: float) -> void:
	if chase_player == true:
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
	if body.name == "Player":
		Game.damage(ATTACK_DAMAGE)
		Game.lower_infection(INFECTION)
		queue_free()


func _on_body_area_entered(area: Area2D) -> void:
	if area.name == "Torpedo":
		area.queue_free()
		get_hit(DAMAGE)


func get_hit(value):
	hp -= value
	if hp <= 0:
		Game.lower_infection(INFECTION)
		queue_free()
