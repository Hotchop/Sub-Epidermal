extends Node

var save = ConfigFile.new()
var filepath: String = "user://"
var filename: String = "save.cfg"

func _ready() -> void:
	load_file()

func load_file():
# Load data from a file.
	var err = save.load(filepath + filename)
# If the file didn't load, make new.
	if err != OK:
		AudioManager.musicVolume = AudioManager.MAX_VOLUME
		FxManager.fxVolume = FxManager.MAX_FX
		Game.newGame = true
		Game.stage2 = false
		Game.hardMode = false
		save_file()
	else:
		AudioManager.musicVolume = save.get_value("Save","music")
		FxManager.fxVolume = save.get_value("Save","fx")
		Game.newGame = save.get_value("Save","newGame")
		Game.stage2 = save.get_value("Save","stage2")
		Game.hardMode = save.get_value("Save","hardMode")
		AudioManager.chage_volume(save.get_value("Save","music"))
	

func save_file():
	save.set_value("Save","music",AudioManager.musicVolume)
	save.set_value("Save","fx",FxManager.fxVolume)
	save.set_value("Save","newGame",Game.newGame)
	save.set_value("Save","stage2",Game.stage2)
	save.set_value("Save","hardMode",Game.hardMode)
	
	save.save(filepath + filename)
