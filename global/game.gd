extends Node

const MAX_HP = 100
const MAX_O2 = 600
const MAX_INFECTION = 100
const MAX_CELL = 5

signal healt_changed()
signal death()
signal infection_lowered()
signal infection_cleared()

var musicVolume = 100
var soundVolume = 100

var player_hp: float = MAX_HP
var player_oxigen: float = MAX_O2
var infection_level: float = MAX_INFECTION
var white_blood_cells: int = 0

func heal(value: float):
	if (player_hp + value) >= 100:
		player_hp = 100
	else:
		player_hp += value
	healt_changed.emit()

func damage(value: float):
	if (player_hp - value) <= 0:
		player_hp = 0
		death.emit()
	else:
		player_hp -= value
	healt_changed.emit()
		
func add_cell():
	white_blood_cells += 1
	
func lower_infection(value: float):
	if infection_level > 0:
		infection_level -= value
		infection_lowered.emit()
		if infection_level <= 0:
			infection_cleared.emit()
