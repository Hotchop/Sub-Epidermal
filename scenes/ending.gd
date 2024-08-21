extends Node2D

func _ready() -> void:
	AudioManager.play_action_music()

func _on_exit_pressed() -> void:
	Game.player_hp = Game.MAX_HP
	Game.infection_level = Game.MAX_INFECTION
	Game.player_oxigen = Game.MAX_O2
	Game.white_blood_cells = 0
	Game.stage2 = false
	Game.hardMode = true
	SaveSystem.save_file()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
