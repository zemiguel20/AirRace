class_name Aircraft
extends AnimatableBody3D
## @tutorial(Simplified Airplane Controller): https://kidscancode.org/godot_recipes/3.x/3d/simple_airplane/


@export var forward_speed = 10
@export var turn_yaw_speed = 1
@export var pitch_speed = 1
@export var turn_roll_speed: float = 3.0 ## Wings "autolevel" speed
@export var turn_roll_angle: float = 0.7

var turn_input: float = 0.0
var pitch_input: float = 0.0


func _ready() -> void:
	sync_to_physics = false # NOTE: must be turned off because is moved with move_and_collide


func _process(delta: float) -> void:
	# Turn (roll/yaw) input
	turn_input = 0.0
	turn_input -= Input.get_action_strength("roll_right")
	turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	pitch_input = 0.0
	pitch_input -= Input.get_action_strength("pitch_down")
	pitch_input += Input.get_action_strength("pitch_up")


func _physics_process(delta: float) -> void:
	# Movement forward
	var velocity = transform.basis.z * forward_speed
	var _collision_data = move_and_collide(velocity * delta)
	# Rotate based on input
	transform.basis = transform.basis.rotated(transform.basis.x, -pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_yaw_speed * delta)
	rotation.z = lerp(rotation.z, -turn_input * turn_roll_angle, turn_roll_speed * delta)
