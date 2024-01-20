@tool
extends CanvasLayer


@export_group("Time")


## Chronometer time
@export var current_time_ms: int = 0:
	set(new_time):
		current_time_ms = new_time
		if current_time_ms < 0: current_time_ms = 0


## If there is no previous record (first run)
@export var no_record: bool = false


## Record time for current gate
@export var gate_time_ms: int = 0:
	set(new_time):
		gate_time_ms = new_time
		if gate_time_ms < 0: gate_time_ms = 0


## Record time for finishing race
@export var record_time_ms: int = 0:
	set(new_time):
		record_time_ms = new_time
		if record_time_ms < 0: record_time_ms = 0


@export_group("Completion")


## Race total gate count
@export var total_gate_count: int = 1:
	set(new_count):
		total_gate_count = new_count
		if total_gate_count < 1: total_gate_count = 1 # Always at least 1 gate


## How many gates the player has checked
@export var current_gate_count: int = 0:
	set(new_count):
		current_gate_count = new_count
		current_gate_count = clamp(current_gate_count, 0, total_gate_count)


@export_group("Waypoint")


@export var waypoint_enabled := false:
	set(value):
		waypoint_enabled = value
		%Waypoint.visible = waypoint_enabled

## Global position of the target gate in the race
@export var target_gate_pos := Vector3.ZERO


func _process(delta: float) -> void:
	_update_chrono_label()
	_update_time_difference_label()
	_update_record_label()
	_update_race_completion_label()
	_update_waypoint()


func _update_chrono_label():
	if %Chrono != null:
		%Chrono.text = _time_ms_to_string(current_time_ms)


func _update_time_difference_label():
	if no_record:
		%TimeDifference.text = "--:--.--"
		%TimeDifference.label_settings.font_color = Color.DIM_GRAY
		return
	
	var time_diff_ms = gate_time_ms - current_time_ms
	if time_diff_ms >= 0: # Winning
		%TimeDifference.label_settings.font_color = Color.GREEN
		%TimeDifference.text = "- " + _time_ms_to_string(abs(time_diff_ms))
	else: # Losing
		%TimeDifference.label_settings.font_color = Color.RED
		%TimeDifference.text = "+ " + _time_ms_to_string(abs(time_diff_ms))


func _update_record_label():
	if no_record:
		%RecordTime.text = "--:--.--"
		%RecordTime.label_settings.font_color = Color.DIM_GRAY
		return
	
	%RecordTime.text = _time_ms_to_string(record_time_ms)
	%RecordTime.label_settings.font_color = Color.DARK_GRAY


func _time_ms_to_string(time_ms: int) -> String:
	var minutes:int = time_ms / 60000
	var seconds:int = (time_ms % 60000) / 1000
	var miliseconds:int = (time_ms % 60000) % 1000
	var time_str = "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
	return time_str


func _update_race_completion_label():
	var percentage = (float(current_gate_count) / float(total_gate_count)) * 100
	%Percentage.text = "%d%%" % percentage


func _update_waypoint():
	if waypoint_enabled:
		%Waypoint.visible = true
		var current_cam := get_viewport().get_camera_3d()
		if current_cam != null:
			# TODO finish this part after level logic
			%Waypoint.visible = not current_cam.is_position_behind(target_gate_pos)
			%Waypoint.position = current_cam.unproject_position(target_gate_pos)
	else:
		%Waypoint.visible = false

