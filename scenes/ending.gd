extends Node2D

func _ready() -> void:
	AudioManager.play_action_music()

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
