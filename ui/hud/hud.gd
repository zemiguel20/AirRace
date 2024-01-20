@tool
extends CanvasLayer


@export_group("Time")


## Chronometer time
@export var current_time_ms: int = 0:
	set(new_time):
		current_time_ms = new_time
		if current_time_ms < 0: current_time_ms = 0
		_update_chrono_label()
		_update_time_difference_label()


## If there is no previous record (first run)
@export var no_record: bool = false:
	set(value):
		no_record = value
		_update_time_difference_label()
		_update_record_label()


## Record time for current gate
@export var gate_time_ms: int = 0:
	set(new_time):
		gate_time_ms = new_time
		if gate_time_ms < 0: gate_time_ms = 0
		_update_time_difference_label()


## Record time for finishing race
@export var record_time_ms: int = 0:
	set(new_time):
		record_time_ms = new_time
		if record_time_ms < 0: record_time_ms = 0 # Minimum 0
		_update_record_label()


@export_group("Completion")


## Race total gate count
@export var total_gate_count: int = 1:
	set(new_count):
		total_gate_count = new_count
		if total_gate_count < 1: total_gate_count = 1 # Always at least 1 gate
		_update_race_completion_label()


## How many gates the player has checked
@export var current_gate_count: int = 0:
	set(new_count):
		current_gate_count = new_count
		current_gate_count = clamp(current_gate_count, 0, total_gate_count)
		_update_race_completion_label()


func _update_chrono_label():
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
	%RecordTime.label_settings.font_color = Color.WHITE


func _update_race_completion_label():
	var percentage = (float(current_gate_count) / float(total_gate_count)) * 100
	%Percentage.text = str(percentage) + "%"
	

func _time_ms_to_string(time_ms: int) -> String:
	var minutes:int = time_ms / 60000
	var seconds:int = (time_ms % 60000) / 1000
	var miliseconds:int = (time_ms % 60000) % 1000
	var time_str = "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
	return time_str
