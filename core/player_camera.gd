extends Camera3D

@export var aircraft: Aircraft = null

## Base position offset relative to aircraft
@export var base_pos_offset: Vector3 = Vector3(0, 0.1, -2.7)
## Speed of snapping between angles when turning
@export var snap_speed = 3
## Bonus offset amount
@export var bonus_offset = 0.5

# Used for interpolation
var current_bonus_offset = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# INIT CAMERA POSITION AND ORIENTATION
	# Position with offset
	position = aircraft.to_global(base_pos_offset)
	# Face the aircraft
	rotation = aircraft.rotation
	rotate_object_local(Vector3.UP, PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Read input
	var yaw_input = Input.get_axis("turn_right", "turn_left")
	var pitch_input = Input.get_axis("pitch_down", "pitch_up")
	# Bonus offset depending on input. Interpolation smoothing
	var target_bonus_offset = Vector3(yaw_input, pitch_input, 0) * bonus_offset
	current_bonus_offset = current_bonus_offset.lerp(target_bonus_offset, snap_speed * delta)
	
	# Position behind aircraft with offset
	position = aircraft.to_global(base_pos_offset + current_bonus_offset)
	
	# Face the aircraft
	rotation = aircraft.rotation
	rotate_object_local(Vector3.UP, PI)
