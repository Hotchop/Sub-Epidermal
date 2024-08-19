extends Node2D


func _ready() -> void:
	AudioManager.play_menu_music()
	$"Settings/VBoxContainer/Music Slider".value = AudioManager.musicVolume - AudioManager.MIN_VOLUME
	$"Settings/VBoxContainer/Effects Slider".value = FxManager.fxVolume - FxManager.MIN_FX

func _on_start_pressed() -> void:
	FxManager.play_fx(FxManager.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://scenes/intro.tscn")


func _on_credits_pressed() -> void:
	FxManager.play_fx(FxManager.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_exit_pressed() -> void:
	FxManager.play_fx(FxManager.BUTTON_CLICK)
	get_tree().quit()


func _on_settings_pressed() -> void:
	FxManager.play_fx(FxManager.BUTTON_CLICK)
	$Settings.visible = true
	$Menu.visible = false


func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.chage_volume(value)


func _on_effects_slider_value_changed(value: float) -> void:
	FxManager.change_fx(value)


func _on_back_pressed() -> void:
	SaveSystem.save_file()
	FxManager.play_fx(FxManager.BUTTON_CLICK)
	$Settings.visible = false
	$Menu.visible = true


func _on_effects_slider_drag_ended(_value_changed: bool) -> void:
	FxManager.play_fx(FxManager.BUTTON_CLICK)
