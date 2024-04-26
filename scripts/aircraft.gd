class_name Aircraft
extends AnimatableBody3D
## @tutorial(Simplified Airplane Controller): https://kidscancode.org/godot_recipes/3.x/3d/simple_airplane/


signal crashed
@export var forward_speed = 20
@export var pitch_speed = 1.5
@export var turn_speed = 1.9
@export var input_response = 8.0
var angular_velocity = Vector3.ZERO
var _stabilizing = false
@onready var player_input_component = $PlayerInputComponent


func _ready():
	rotate_y(0.0001) # HACK: Upside down Z angle is 0 until Y is rotated (?)


func _physics_process(delta):
	# Read input
	var pitch_input = player_input_component.pitch_input
	var turn_input = player_input_component.turn_input
	
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
	
	# If not turning, roll back to upright position
	if not _stabilizing and is_upside_down and pitch_input == 0.0 and turn_input == 0.0:
		_stabilize()
	
	# Move forward / Thrust
	var velocity = transform.basis.z * forward_speed
	var _collision_data = move_and_collide(velocity * delta)
	# Process collision
	if _collision_data != null:
		crashed.emit()


func reset_rotation():
	var model = $Model as Node3D
	var wing_col  = $WingCollisionShape as Node3D
	model.rotation.z = 0.0
	wing_col.rotation.z = 0.0
	
	angular_velocity = Vector3.ZERO


func _stabilize():
	_stabilizing = true
	var tween = create_tween().bind_node(self)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation:z", 0.0, 1.0)
	await tween.finished
	_stabilizing = false
