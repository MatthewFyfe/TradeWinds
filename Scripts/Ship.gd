extends KinematicBody

var move_speed = 10
var target_position = transform.origin
var current_position = transform.origin

#On object ready
func _ready():
	add_to_group("ships")
	
#Every physics tick
func _physics_process(delta):
	#Called multiple times to speed up distance per tick
	move_and_slide(target_position - transform.origin, Vector3(0, 0, 0), false, 1, 0.2617994, true)
	move_and_slide(target_position - transform.origin, Vector3(0, 0, 0), false, 1, 0.2617994, true)
	
	#Handle collisions if needed
	if get_slide_count() > 0:
		#Check what we hit
		print(get_slide_collision(0).collider.name)
		#Go back to last grid location
		target_position = current_position

#Handle wind blowing ships
func blow_direction(direction):
	#Update our current (last) position and round off
	current_position = transform.origin
	#current_position.x = floor(current_position.x / 5) * 5
	
	if direction == "north":
		target_position -= Vector3(0,0,-move_speed)
	if direction == "south":
		target_position -= Vector3(0,0,move_speed)
	if direction == "west":
		target_position -= Vector3(-move_speed,0,0)
	if direction == "east":
		target_position -= Vector3(move_speed,0,0)
