extends Control

var visible_characters = 0

func _process(_delta: float) -> void:
	if visible_characters != $Banner/RichTextLabel.visible_characters && $AudioStreamPlayer.get_parent().visible:
		visible_characters = $Banner/RichTextLabel.visible_characters
		$AudioStreamPlayer.play();


func popup(value: String):
	$AudioStreamPlayer.volume_db = FxManager.fxVolume
	$Banner/RichTextLabel.text = value
	$Banner/RichTextLabel.visible_ratio = 0
	$".".visible = true
	$AnimationPlayer.play("popup")
	print('Finished Popup')
