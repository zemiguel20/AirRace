extends Camera3D

@export var aircraft: Aircraft = null

# Base position offset relative to aircraft
const BASE_POS_OFFSET: Vector3 = Vector3(0, 0.1, -2.7)
# Speed of snapping between angles when turning
const SNAP_SPEED = 3
# Bonus offset amount
const BONUS_OFFSET = 0.5

# Used for interpolation
var current_bonus_offset = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# INIT CAMERA POSITION AND ORIENTATION
	# Position with offset
	position = aircraft.to_global(BASE_POS_OFFSET)
	# Face the aircraft
	rotation = aircraft.rotation
	rotate_object_local(Vector3.UP, PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Read input
	var yaw_input = Input.get_axis("turn_right", "turn_left")
	var pitch_input = Input.get_axis("pitch_down", "pitch_up")
	# Bonus offset depending on input. Interpolation smoothing
	var target_bonus_offset = Vector3(yaw_input, pitch_input, 0) * BONUS_OFFSET
	current_bonus_offset = current_bonus_offset.lerp(target_bonus_offset, SNAP_SPEED * delta)
	
	# Position behind aircraft with offset
	position = aircraft.to_global(BASE_POS_OFFSET + current_bonus_offset)
	
	# Face the aircraft
	rotation = aircraft.rotation
	rotate_object_local(Vector3.UP, PI)
