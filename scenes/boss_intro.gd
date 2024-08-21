extends Node2D

var success = false

func _ready() -> void:
	Game.stage2 = true
	AudioManager.play_action_music()
	$AudioStreamPlayer.volume_db = FxManager.volume_db

func _process(_delta: float) -> void:
	track_time_button()

func track_time_button():
	var button_time = 2
	if Input.is_action_just_pressed("ui_accept"):
		$"Skip Intro".start(button_time)
	if Input.is_action_just_released("ui_accept"):
		$"Skip Intro".stop()
		if success:
			success = false
		else:
			print('fail')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boss_enter":
		get_tree().change_scene_to_file("res://scenes/bossfight.tscn")


func _on_skip_intro_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/bossfight.tscn")
