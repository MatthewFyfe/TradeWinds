extends MeshInstance

var currentAngle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Every physics tick
func _physics_process(delta):
	currentAngle += 1
	rotate_y(deg2rad(currentAngle))
