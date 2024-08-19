extends Node2D

func _ready() -> void:
	AudioManager.play_game_over_music()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/heart_level.tscn")


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
