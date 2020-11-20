extends MarginContainer


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		exit()

func _on_start_gui_input(event: InputEvent):
	if event.is_pressed():
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/space.tscn")


func _on_chooser_gui_input(event: InputEvent):
	if event.is_pressed():
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/chooser.tscn")


func _on_exit_gui_input(event: InputEvent):
	if event.is_pressed():
		exit()

func exit():
	get_tree().quit()
