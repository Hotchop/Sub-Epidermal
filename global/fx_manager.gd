extends AudioStreamPlayer

##Game Effects
const BUTTON_CLICK = preload("res://assets/audio/effects/button click.ogg")
const EXPLOSION = preload("res://assets/audio/effects/explosion.ogg")
const HIT = preload("res://assets/audio/effects/hit.ogg")
const PICKUP = preload("res://assets/audio/effects/pickup.ogg")
const ROCKS = preload("res://assets/audio/effects/rock-destroy.wav")
const TYPE = preload("res://assets/audio/effects/typing.ogg")
const TORPEDO = preload("res://assets/audio/effects/torpedo.ogg")

const MAX_FX = 0.0
const MIN_FX = -50.0

@onready var fxVolume = SaveSystem.save.get_value("Save","music")
	

func play_fx(fx: AudioStream, volume = fxVolume):
	stream = fx
	volume_db = volume
	play()

func change_fx(value):
	fxVolume = value + MIN_FX
