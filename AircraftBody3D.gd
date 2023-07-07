class_name AircraftBody3D
extends RigidBody3D

@export
## Thrust acceleration
var thrust_power = 100

@export
var drag_coefficient = 1
@export
## Angle of attack makes the drag stronger
## This curve gives a multiplier depending on AoA
## X- Normalized angle, Y- Drag scale
var drag_aoa_curve: Curve 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	var velocity_square = linear_velocity.length_squared()
	# ANGLE OF ATTACK
	var aoa = linear_velocity.normalized().angle_to(transform.basis.z)
	var aoa_norm = aoa / PI
	# Calculate G-force
	
	# THRUST
	var thrust_direction = transform.basis.z
	var thrust: Vector3 = thrust_power * thrust_direction
	
	# DRAG
	var drag_direction = -linear_velocity.normalized()
	var drag_multiplier = drag_aoa_curve.sample(aoa_norm)
	var drag: Vector3 = velocity_square/2 * drag_coefficient * drag_multiplier * drag_direction
	
	
	
	# Calculate Lift (v²/2 * lift_coefficient * lift_multiplier)
	# Normalized Curve AoA-Coefficient. Multiplier to edit lift strength
	
	# Calculate Induced Drag (lift_coefficient² * induced_drag_constant)
	
	var integrated_force: Vector3 = thrust + drag
	apply_central_force(integrated_force * delta)
	print(linear_velocity.length())
