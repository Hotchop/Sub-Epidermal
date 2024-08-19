extends AudioStreamPlayer

##Game Music

const menuMusic = preload("res://assets/audio/music/Menu Music.ogg")
const gameMusic = preload("res://assets/audio/music/Game Music.ogg")
const gameOverMusic = preload("res://assets/audio/music/Game Over.ogg")
const actionMusic = preload("res://assets/audio/music/Action Music.ogg")

const MAX_VOLUME = 0.0
const MIN_VOLUME = -50.0

@onready var musicVolume = SaveSystem.save.get_value("Save","music")

func _play_music(music: AudioStream, volume = musicVolume):
	if stream == music:
		return
	stream = music
	volume_db = volume
	if music == actionMusic:
		volume_db -= 10
	play()
	
func chage_volume(value):
	musicVolume = value + MIN_VOLUME
	volume_db = musicVolume
	if stream == actionMusic:
		volume_db -= 10

func play_menu_music():
	_play_music(menuMusic)

func play_game_music():
	_play_music(gameMusic)

func play_game_over_music():
	_play_music(gameOverMusic)

func play_action_music():
	_play_music(actionMusic)
