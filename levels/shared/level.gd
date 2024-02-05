extends Node


var _is_racing := false
var _chrono_ms := 0
var _record_times: Array = []
var _gates: Array = []
var _current_gate = null


func _ready() -> void:
	# Check level data
	var data = GameData.level_data.get(name)
	if data == null:
		$HUD.no_record = true
	else:
		_record_times = data
		$HUD.record_time_ms = _record_times.back()
		$HUD.gate_time_ms = _record_times.pop_front()
	
	# Get gates
	_gates = $Gates.get_children()
	$HUD.total_gate_count = _gates.size()
	# Activate first gate
	_current_gate = _gates.pop_front()
	_current_gate.activate()
	# Deactivate rest of gates
	for gate in _gates:
		gate.deactivate()
	
	# Set waypoint for first gate
	$HUD.waypoint_enabled = true
	$HUD.target_gate_pos = _current_gate.global_position


func _process(delta: float) -> void:
	if _is_racing:
		_chrono_ms += int(delta * 1000.0)
	$HUD.current_time_ms = _chrono_ms


# For intro sequence
func _set_timer_text(text:String):
	print(text)
	%Timer.text = text


func _start_race():
	_is_racing = true
	$Jet.process_mode = Node.PROCESS_MODE_INHERIT


func _on_gate_body_entered(_body: Node3D) -> void:
	_current_gate.deactivate()
	_current_gate = _gates.pop_front()
	if _current_gate == null:
		_finish_race()
	else:
		_current_gate.activate()
		$HUD.current_gate_count += 1
		$HUD.gate_time_ms = _record_times.pop_front()
		$HUD.target_gate_pos = _current_gate.global_position


func _finish_race():
	print("Race Finished")
	_is_racing = false
	$Jet.process_mode = Node.PROCESS_MODE_DISABLED
	$HUD.waypoint_enabled = false
