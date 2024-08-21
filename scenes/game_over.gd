extends Node2D

func _ready() -> void:
	AudioManager.play_game_over_music()
	if Game.hardModeGame:
		Game.stage2 = false
		$CenterContainer/VBoxContainer/CenterContainer2/Return.visible = false

func _on_return_pressed() -> void:
	Game.player_hp = Game.MAX_HP
	Game.infection_level = Game.MAX_INFECTION
	Game.player_oxigen = Game.MAX_O2
	Game.white_blood_cells = 0
	if Game.stage2 == false:
		get_tree().change_scene_to_file("res://scenes/heart_level.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/bossfight.tscn")


func _on_exit_pressed() -> void:
	Game.player_hp = Game.MAX_HP
	Game.infection_level = Game.MAX_INFECTION
	Game.player_oxigen = Game.MAX_O2
	Game.white_blood_cells = 0
	SaveSystem.save_file()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
