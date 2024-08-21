extends Node2D

func _ready() -> void:
	Game.death.connect(player_died)
	$"Great Indigestion".boss_death.connect(victory)
	AudioManager.play_action_music()
	Game.player_hp = Game.MAX_HP

func _process(_delta: float) -> void:
	$"CanvasLayer/Progress Bars/HP".value = Game.player_hp
	$"CanvasLayer/Progress Bars/Boss HP".value = $"Great Indigestion".hp
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused == false:
		get_tree().paused = true
		$Pause.visible = true
	
func player_died():
	$Player.explode()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func victory():
	get_tree().change_scene_to_file("res://scenes/ending.tscn")
