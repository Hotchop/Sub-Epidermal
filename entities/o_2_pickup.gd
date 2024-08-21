extends Area2D

const oxigen = 30

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.o2_refill.emit(oxigen)
		FxManager.play_fx(FxManager.PICKUP)
		self.queue_free()
