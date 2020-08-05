extends Spatial

var windTimer = 0

onready var progressWind = find_node("ProgressWind")
onready var windReady = find_node("WindReady")

#Every physics tick (built in function)
func _physics_process(delta):
	if(windTimer >= 0):
		windReady.hide()
		windTimer -= 1
	else:
		windReady.show()
	#Update wind progress bar
	progressWind.value = 100-windTimer

#Check for input (built in function)
func _input(event):
	# Check and handle player input
	var eText = event.as_text()
	if eText == "Up" or eText == "Down" or eText == "Left" or eText == "Right":
		inputHelper(event.as_text())
	
func inputHelper(eventName):
	if windTimer <= 0:
		if eventName == "Up":
			get_tree().call_group("ships", "blow_direction", "north")
		if eventName == "Left":
			get_tree().call_group("ships", "blow_direction", "west")
		if eventName == "Right":
			get_tree().call_group("ships", "blow_direction", "east")
		if eventName == "Down":
			get_tree().call_group("ships", "blow_direction", "south")
			
		#temporarily disable input
		wind_timer()

#Start the cooldown timer for wind controls
func wind_timer():
	windTimer = 100


func _on_Button_N_pressed():
	inputHelper("Up")


func _on_Button_S_pressed():
	inputHelper("Down")


func _on_Button_W_pressed():
	inputHelper("Left")


func _on_Button_E_pressed():
	inputHelper("Right")
