extends Node2D



func _ready() -> void:
	$"CanvasLayer/Progress Bars/Oxigen".value = Game.player_oxigen

func _on_timer_timeout() -> void:
	$"CanvasLayer/Progress Bars/Oxigen".value -= 1

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
		message = "This white blood cells might come in handy. Better take them with me."
	elif Game.white_blood_cells == 3:
		message = "A couple more cells and I could clear that big obstruction at the heart."
	elif Game.white_blood_cells == 5 and Game.infection_level > 0:
		message = "I should have enough cells now. I'll finish clearing the infection and then I'll clear the obstruction."
	elif Game.white_blood_cells == 5 and Game.infection_level <= 0:
		message = "That's the last cell. All that remains is to clear the obstruction at the heart."
	$"CanvasLayer/Dialog Popup".popup(message)

#Big Stone
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		if Game.white_blood_cells < 5 and Game.infection_level > 0:
			$"CanvasLayer/Dialog Popup".popup('This obstruction is to dense. I should find some help to clear it up.')
		elif Game.white_blood_cells == 5 and Game.infection_level <= 0:
			$"CanvasLayer/Dialog Popup".popup('I should get rid of the infection before moving forward.')
		elif Game.white_blood_cells < 5 and Game.white_blood_cells > 0 and Game.infection_level <= 0:
			$"CanvasLayer/Dialog Popup".popup("I'm gonna need more white cells if I want to clear the way.")
		else:
			#End Level
			pass
