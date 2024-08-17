extends Area2D

signal health_full(message: String)

const HEAL = 20

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Game.player_hp < 100:
			Game.heal(HEAL)
			self.queue_free()
		else:
			health_full.emit("I don't need repairs at the moment")
