class_name Aircraft
extends AnimatableBody3D
## @tutorial(Simplified Airplane Controller): https://kidscancode.org/godot_recipes/3.x/3d/simple_airplane/


@export var forward_speed = 20
@export var pitch_speed = 1.5
@export var turn_speed = 1.9
@export var input_response = 8.0
var pitch_input = 0.0
var turn_input = 0.0


func _physics_process(delta):
	# Read input
	pitch_input = lerp(pitch_input, Input.get_axis("pitch_down", "pitch_up"), input_response * delta)
	turn_input = lerp(turn_input, Input.get_axis("turn_left", "turn_right"), input_response * delta)
	# Pitch
	# TODO: LIMIT ROTATION TO NOT ALLOW UPSIDE DOWN, SO MAX ANGLE IS 90 POINTING UP OR -90 POINTING DOWN
	rotate(-transform.basis.x, pitch_input * pitch_speed * delta)
	# Turn
	rotate(Vector3.DOWN, turn_input * turn_speed * delta)
	# Bank turn animation
	var model = $Model as Node3D
	var wing_col  = $WingCollisionShape as Node3D
	model.rotation.z = lerp(model.rotation.z, deg_to_rad(45) * turn_input, input_response * delta)
	wing_col.rotation.z = lerp(wing_col.rotation.z, deg_to_rad(45) * turn_input, input_response * delta)
	# Move forward / Thrust
	var velocity = transform.basis.z * forward_speed
	var _collision_data = move_and_collide(velocity * delta)
	# TODO: check if collision
