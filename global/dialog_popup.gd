extends Control


func popup(value: String):
	$Banner/RichTextLabel.text = value
	$Banner/RichTextLabel.visible_ratio = 0
	$".".visible = true
	$AnimationPlayer.play("popup")
	print('Finished Popup')
