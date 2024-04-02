class_name Aircraft
extends AnimatableBody3D
## @tutorial(Simplified Airplane Controller): https://kidscancode.org/godot_recipes/3.x/3d/simple_airplane/


@export var thrust: float = 10
@export var turn_speed: float = 1
@export var pitch_speed: float = 1
@export var roll_speed: float = 1
@export_range(0.0, 10) var angular_drag: float = 0.5 ## 1 - no rotation smoothing, 0 - infinite rotation "drift"

var turn_input: float = 0.0
var pitch_input: float = 0.0
var roll_input: float = 0.0

var lin_velocity: Vector3 = Vector3.ZERO
var ang_velocity: Vector3 = Vector3.ZERO


func _process(delta: float) -> void:
	pitch_input = Input.get_axis("pitch_down", "pitch_up")
	turn_input = Input.get_axis("turn_left", "turn_right")
	roll_input = Input.get_axis("roll_left", "roll_right")


func _physics_process(delta: float) -> void:
	# Movement forward
	lin_velocity = transform.basis.z * thrust
	var _collision_data = move_and_collide(lin_velocity * delta)
	# Rotate based on input
	var target_ang_velocity = Vector3(pitch_input * pitch_speed, turn_input * turn_speed, roll_input * roll_speed)
	ang_velocity = ang_velocity.lerp(target_ang_velocity, angular_drag * delta)
	rotate(-transform.basis.x, ang_velocity.x * delta)
	rotate(-transform.basis.y, ang_velocity.y * delta)
	rotate(transform.basis.z, ang_velocity.z * delta)
	
	# TODO: Bank turn animation
