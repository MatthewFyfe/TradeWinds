extends Spatial

var windTimer = 0

#Every physics tick (built in function)
func _physics_process(delta):
	if(windTimer >= 0):
		windTimer -= 1

#Check for input (built in function)
func _input(event):
	# Check and handle player input
	if windTimer <= 0:
		if event.is_action_pressed("ui_up"):
			get_tree().call_group("ships", "blow_direction", "north")
		if event.is_action_pressed("ui_left"):
			get_tree().call_group("ships", "blow_direction", "west")
		if event.is_action_pressed("ui_right"):
			get_tree().call_group("ships", "blow_direction", "east")
		if event.is_action_pressed("ui_down"):
			get_tree().call_group("ships", "blow_direction", "south")
			
		#temporarily disable input
		wind_timer()

#Start the cooldown timer for wind controls
func wind_timer():
	windTimer = 125
