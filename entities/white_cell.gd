extends Area2D

signal picked_up()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		FxManager.play_fx(FxManager.PICKUP)
		Game.add_cell()
		picked_up.emit()
		self.queue_free()
