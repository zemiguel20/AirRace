@icon("res://aircraft_controller/aeroplane_icon.svg")
## Simple arcade aircraft controller
class_name Aircraft
extends AnimatableBody3D

@export_range(1, 50, 1) var forward_speed: float = 20
## Downward boost makes descent faster, climb slower, and aircraft fall slightly while rolling.
@export_range(1, 50, 1) var downward_boost: float = 10

@export_range(0, 10, 0.1) var roll_speed: float = 3
@export_range(0, 10, 0.1) var pitch_speed: float = 2
@export_range(0, 10, 0.1) var yaw_speed: float = 1

## Higher value means rotation less drifty
@export_range(0.1, 20, 0.1) var rotation_drag: float = 3
## Higher value means less drifting
@export_range(0.1, 20, 0.1) var movement_drag: float = 3

# Current angular velocity
var current_ang_vel = Vector3.ZERO
# Current linear velocity
var current_lin_vel = Vector3.ZERO

# Downward velocity depends on the tilt angle
var _down_vel_curve: Curve

func _ready():
	# Construct curve to sample downwards velocity from angle
	_down_vel_curve = Curve.new()
	_down_vel_curve.add_point(Vector2(0, 0))
	_down_vel_curve.add_point(Vector2(0.5, downward_boost))
	_down_vel_curve.add_point(Vector2(0, 1))
	_down_vel_curve.bake()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_process_rotation(delta)
	_process_movement(delta)

func _process_rotation(delta):
	# Read input
	var roll_input = Input.get_axis("roll_left", "roll_right")
	var yaw_input = Input.get_axis("turn_right", "turn_left")
	var pitch_input = Input.get_axis("pitch_up", "pitch_down")
	
	# Calculate target angular velocity
	var target_ang_vel = Vector3(pitch_input * pitch_speed, \
								yaw_input * yaw_speed, \
								roll_input * roll_speed)
	
	# Update current angular velocity
	var lerp_weight = clampf(rotation_drag * delta, 0, 1) #Clamp fixes jitter
	current_ang_vel = current_ang_vel.lerp(target_ang_vel, lerp_weight) 
	
	# Rotate aircraft
	var rotation_step: Vector3 = current_ang_vel * delta
	rotate_object_local(Vector3.MODEL_LEFT, rotation_step.x)
	rotate_object_local(Vector3.MODEL_TOP, rotation_step.y)
	rotate_object_local(Vector3.MODEL_FRONT, rotation_step.z)
	
func _process_movement(delta):
	# Calculate thrust
	var thrust: Vector3 = forward_speed * transform.basis.z
	
	# Calculate downwards velocity
	var tilt_angle = transform.basis.y.angle_to(Vector3.UP) / PI # Curve is normalized
	var gravity: Vector3 = _down_vel_curve.sample(tilt_angle) * Vector3.DOWN
	
	# Target linear velocity
	var target_lin_velocity = thrust + gravity
	
	# Update current linear velocity
	var lerp_weight = clampf(movement_drag * delta, 0, 1) #Clamp fixes jitter
	current_lin_vel = current_lin_vel.lerp(target_lin_velocity, lerp_weight)
	
	# Move aircraft
	move_and_collide(current_lin_vel * delta)
