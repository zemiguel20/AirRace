extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotationInput: Vector2 = Vector2(0, 0)
	if Input.is_key_pressed(KEY_A):
		rotationInput.x += 1
	if Input.is_key_pressed(KEY_D):
		rotationInput.x -= 1
	if Input.is_key_pressed(KEY_W):
		rotationInput.y += 1
	if Input.is_key_pressed(KEY_S):
		rotationInput.y -= 1
	
	rotate(Vector3.UP, 5*rotationInput.x*delta)
