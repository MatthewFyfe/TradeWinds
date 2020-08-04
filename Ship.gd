extends KinematicBody

var move_speed = 5
var target_position = transform.origin

func _ready():
	add_to_group("ships")
	
func _physics_process(delta):
	move_and_slide(target_position - transform.origin)
	#move_and_collide(target_position - transform.origin)

func blow_direction(direction):
	if direction == "north":
		target_position -= Vector3(0,0,-5)
	if direction == "south":
		target_position -= Vector3(0,0,5)
	if direction == "west":
		target_position -= Vector3(-5,0,0)
	if direction == "east":
		target_position -= Vector3(5,0,0)
