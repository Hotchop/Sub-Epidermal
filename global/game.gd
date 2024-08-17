extends Node

const MAX_HP = 100
const MAX_O2 = 600
const MAX_INFECTION = 100
const MAX_CELL = 5

var player_hp: float = MAX_HP
var player_oxigen: float = MAX_O2
var infection_level: float = MAX_INFECTION
var white_blood_cells: int = 0

func heal(value: float):
	if (player_hp + value) >= 100:
		player_hp = 100
	else:
		player_hp += value

func damage(value: float):
	if (player_hp - value) <= 0:
		player_hp = 0
	else:
		player_hp -= value
		
func add_cell():
	white_blood_cells += 1
