class_name AircraftBody3D

extends RigidBody3D

@export
var rotation_h_speed = PI*0.1
@export
var rotation_v_speed = PI*0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target: Vector3 = Vector3(0, 0, 1);
	if Input.is_key_pressed(KEY_A):
		target.x -= 1
	if Input.is_key_pressed(KEY_D):
		target.x += 1
	if Input.is_key_pressed(KEY_W):
		target.y += 1
	if Input.is_key_pressed(KEY_S):
		target.y -= 1
	
	Vector3.FORWARD
	# ROTATE
