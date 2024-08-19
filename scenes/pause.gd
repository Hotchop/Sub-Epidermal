extends CanvasLayer


func _on_back_pressed() -> void:
	get_tree().paused = false
	$".".visible = false


func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
