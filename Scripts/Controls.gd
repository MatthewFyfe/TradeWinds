# Controls and Game Logic
extends Spatial

var windTimer = 0
var goalCount = 0
export var goalLimit = 2
export var active_ships = 2

onready var progressWind = find_node("ProgressWind")
onready var windReady = find_node("WindReady")
onready var windGustFX = find_node("WindGust")
onready var sailsFX = find_node("Sails")

#Every physics tick (built in function)
# warning-ignore:unused_argument
func _physics_process(delta):
	if(windTimer >= 0):
		windReady.hide()
		windTimer -= 1
	else:
		windReady.show()
		windGustFX.stop()
		#sailsFX.stop()
		
	#Update wind progress bar
	progressWind.value = 100-windTimer
	#Update goal counter
	find_node("GoalCount").set_text("Goal " + str(goalCount) + "/" + str(goalLimit))
	#Check win condition
	if(goalCount >= goalLimit):
		#print("win")
		var popup = find_node("WinPopup")
		popup.show()
	#Check loss condition
	if(active_ships < goalLimit):
		#print("lost")
		var popup = find_node("LosePopup")
		popup.show()

func active_ships(value):
	active_ships += value

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

func add_goalCount(value):
	goalCount += value


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_MenuButton2_pressed():
	get_tree().reload_current_scene()


func _on_Button_Menu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Button_Retry_pressed():
	get_tree().reload_current_scene()
