extends Node2D



func _ready() -> void:
	Game.infection_lowered.connect(_on_infection_lowered)
	Game.infection_cleared.connect(_on_infection_cleared)
	Game.healt_changed.connect(_on_hp_change)
	Game.death.connect(player_died)
	$"CanvasLayer/Progress Bars/Oxigen".value = Game.player_oxigen
	$"CanvasLayer/Progress Bars/Infection".value = Game.infection_level
	$"CanvasLayer/Progress Bars/HP".value = Game.player_hp

func _on_timer_timeout() -> void:
	$"CanvasLayer/Progress Bars/Oxigen".value -= 1
	if $"CanvasLayer/Progress Bars/Oxigen".value <= 0:
		player_died()

func _on_infection_lowered():
	$"CanvasLayer/Progress Bars/Infection".value = Game.infection_level
	
func _on_infection_cleared():
	$"CanvasLayer/Dialog Popup".popup("Infections levels have stabilized! Time to get out of here...")

func _on_hp_change():
	$"CanvasLayer/Progress Bars/HP".value = Game.player_hp

#Progression
func player_died():
	$Player.queue_free()
	await get_tree().create_timer(2).timeout

#Blood Cells
func _on_blood_cell_health_full(message: String) -> void:
	print('Touched Cell')
	$"CanvasLayer/Dialog Popup".popup(message)

func _on_blood_cell_2_health_full(message: String) -> void:
	print('Touched Cell')
	$"CanvasLayer/Dialog Popup".popup(message)

func _on_blood_cell_3_health_full(message: String) -> void:
	print('Touched Cell')
	$"CanvasLayer/Dialog Popup".popup(message)

#White Cells
func _on_white_cell_picked_up() -> void:
	white_cell_picked()
func _on_white_cell_2_picked_up() -> void:
	white_cell_picked()
func _on_white_cell_3_picked_up() -> void:
	white_cell_picked()
func _on_white_cell_4_picked_up() -> void:
	white_cell_picked()
func _on_white_cell_5_picked_up() -> void:
	white_cell_picked()

func white_cell_picked():
	$"CanvasLayer/Progress Bars/WB Cell Counter".frame += 1
	var message: String
	if Game.white_blood_cells == 1:
		message = "This white blood cell might come in handy. Better take them with me."
	elif Game.white_blood_cells == 3:
		message = "A couple more cells and I could clear that big obstruction at the heart."
	elif Game.white_blood_cells == 5 and Game.infection_level > 0:
		message = "I should have enough cells now. I'll clear the infection first, then I'll remove the obstruction."
	elif Game.white_blood_cells == 5 and Game.infection_level <= 0:
		message = "That's the last cell. All that remains is to clear the obstruction at the heart."
	if message:
		$"CanvasLayer/Dialog Popup".popup(message)

#Big Stone
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		if Game.white_blood_cells < 5 and Game.infection_level > 0:
			$"CanvasLayer/Dialog Popup".popup('This obstruction is too dense. I should find some help to clear it up.')
		elif Game.white_blood_cells == 5 and Game.infection_level <= 0:
			$"CanvasLayer/Dialog Popup".popup('I should get rid of the infection before moving forward.')
		elif Game.white_blood_cells < 5 and Game.white_blood_cells > 0 and Game.infection_level <= 0:
			$"CanvasLayer/Dialog Popup".popup("I'm gonna need more white cells if I want to clear the way.")
		else:
			#End Level
			pass
