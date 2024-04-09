class_name Aircraft
extends AnimatableBody3D
## @tutorial(Simplified Airplane Controller): https://kidscancode.org/godot_recipes/3.x/3d/simple_airplane/


@export var forward_speed = 20
@export var pitch_speed = 1.5
@export var turn_speed = 1.9
@export var input_response = 8.0
var angular_velocity = Vector3.ZERO



func _physics_process(delta):
	# Read input
	var pitch_input = Input.get_axis("pitch_down", "pitch_up")
	if Settings.inverted_pitch_input:
		pitch_input = pitch_input * -1
	var turn_input = Input.get_axis("turn_left", "turn_right")
	if Settings.inverted_turn_input:
		turn_input = turn_input * -1
	
	# Target angular velocity based on input
	var target_angular_velocity = Vector3.ZERO
	target_angular_velocity.x = pitch_input * pitch_speed
	target_angular_velocity.y = turn_input * turn_speed
	
	# Invert turn direction if aircraft upside down
	var is_upside_down = Vector3.UP.angle_to(basis.y) > (PI/2)
	if is_upside_down:
		target_angular_velocity.y *= -1
	
	# Interpolate angular velocity
	angular_velocity = angular_velocity.lerp(target_angular_velocity, input_response * delta)
	
	# Pitch and turn
	rotate(-transform.basis.x, angular_velocity.x * delta) # Use local Right axis, positive angle = pitch up
	rotate(Vector3.DOWN, angular_velocity.y * delta) # Use Down axis, positive angle = turn right
	
	# Bank turn animation
	var model = $Model as Node3D
	var wing_col  = $WingCollisionShape as Node3D
	model.rotation.z = lerpf(model.rotation.z, deg_to_rad(45) * turn_input, input_response * delta)
	wing_col.rotation.z = lerpf(wing_col.rotation.z, deg_to_rad(45) * turn_input, input_response * delta)
	
	# TODO: If upside down, and no input, start stabilization routine
	
	# Move forward / Thrust
	var velocity = transform.basis.z * forward_speed
	var _collision_data = move_and_collide(velocity * delta)
	# TODO: check if collision
