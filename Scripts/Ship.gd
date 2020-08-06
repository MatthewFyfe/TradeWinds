extends KinematicBody

var move_speed = 10
var target_position = transform.origin
var current_position = transform.origin
var shipRegex = RegEx.new()
var notInPort = true
var shipHP = 2

onready var windGust = get_parent().find_node("WindGust")
onready var woodCrash = get_parent().find_node("WoodCrash")
onready var bubbles = get_parent().find_node("Bubbles")
onready var sails = get_parent().find_node("Sails")

#Lazy edge of level settings
var levelSizeX = 50
var levelSizeZ = 50

#On object ready
func _ready():
	add_to_group("ships")
	shipRegex.compile("Ship*")
	
#Every physics tick
func _physics_process(delta):
	#Are we sinking?
	if(shipHP <= 0):
		target_position = target_position + Vector3(0, -0.1, 0)
		bubbles.play()
	#If not, then lets float
	elif(target_position.y < 0):
		target_position = target_position + Vector3(0, 0.1, 0)
		
	#Are we outside play area?
	if (abs(target_position.x) > levelSizeX or abs(target_position.z) > levelSizeZ):
		 target_position = target_position + Vector3(0, -0.15, 0)
		
	#Has Davy Jones got us?
	if(transform.origin.y <= -5):
		print("glub")
		queue_free()
	
	#Called multiple times to hacky speed up distance per tick
	move_and_slide(target_position - transform.origin, Vector3(0, 0, 0), false, 1, 0.2617994, true)
	move_and_slide(target_position - transform.origin, Vector3(0, 0, 0), false, 1, 0.2617994, true)
	
	#Handle collisions if needed
	if get_slide_count() > 0:
		#Check what we hit
		print(get_slide_collision(0).collider.name)
		var whatWeHit = get_slide_collision(0).collider.name
		
		# Did we hit a sandbar?
		if whatWeHit == "Sandbar":
			#Go back to last grid location
			target_position = current_position
		# Was it some kind of ship?
		elif (shipRegex.search(whatWeHit)):
			#Go back to last grid location
			target_position = current_position
		elif whatWeHit == "Rocks":
			#Something bad happens (we sink)
			shipHP -= 1
			woodCrash.play()
			target_position = current_position
		elif whatWeHit == "Port":
			#Success! Update goal count
			if(notInPort):
				get_parent().add_goalCount(1)
				notInPort = false
				current_position = get_slide_collision(0).collider.get_parent().transform.origin
			else:
				target_position = current_position

#Handle wind blowing ships
func blow_direction(direction):
	#Update our current (last) position and round off
	current_position = transform.origin
	#current_position.x = floor(current_position.x / 5) * 5
	if(!notInPort):
		get_parent().add_goalCount(-1)
		notInPort = true
		
	windGust.play()
	#sails.play()
	
	if direction == "north":
		target_position -= Vector3(0,0,-move_speed)
	if direction == "south":
		target_position -= Vector3(0,0,move_speed)
	if direction == "west":
		target_position -= Vector3(-move_speed,0,0)
	if direction == "east":
		target_position -= Vector3(move_speed,0,0)
