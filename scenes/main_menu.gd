extends Node2D


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	$Settings.visible = true
	$Menu.visible = false


func _on_music_slider_value_changed(value: float) -> void:
	Game.musicVolume = value


func _on_effects_slider_value_changed(value: float) -> void:
	Game.soundVolume = value


func _on_back_pressed() -> void:
	$Settings.visible = false
	$Menu.visible = true
