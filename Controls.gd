extends Spatial

func _input(event):
	# Check and handle player input
	if event.is_action_pressed("ui_up"):
		get_tree().call_group("ships", "blow_direction", "north")
	if event.is_action_pressed("ui_left"):
		get_tree().call_group("ships", "blow_direction", "west")
	if event.is_action_pressed("ui_right"):
		get_tree().call_group("ships", "blow_direction", "east")
	if event.is_action_pressed("ui_down"):
		get_tree().call_group("ships", "blow_direction", "south")
