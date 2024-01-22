extends Node


var _is_racing := false
var _chrono_ms := 0
var _record_times = []
var _gates = []
var _gate_count = 0


func _ready() -> void:
	# Check level data
	var data = GameData.level_data.get(name)
	var no_data = data==null
	if no_data:
		$HUD.no_record = true
	else:
		_record_times = data
		$HUD.record_time_ms = _record_times.back()
		$HUD.gate_time_ms = _record_times[_gate_count]
	
	# Get gates
	_gates = $Gates.get_children()
	$HUD.total_gate_count = _gates.size()
	# Deactivate all gates except first one
	for gate in _gates:
		gate.monitoring = false
	_gates[0].monitoring = true
	
	# Set waypoint for first gate
	$HUD.waypoint_enabled = true
	$HUD.target_gate_pos = _gates[0].global_position


func _process(delta: float) -> void:
	if _is_racing:
		_chrono_ms += int(delta * 1000.0)
	$HUD.current_time_ms = _chrono_ms


func _set_timer_text(text:String):
	print(text)
	%Timer.text = text


func _start_race():
	_is_racing = true
	$Jet.process_mode = Node.PROCESS_MODE_INHERIT


func _on_gate_body_entered(_body: Node3D) -> void:
	_gates[_gate_count].monitoring = false
	_gate_count += 1
	$HUD.current_gate_count += 1
	
	if _gate_count == _gates.size():
		_finish_race()
	else:
		$HUD.gate_time_ms = _record_times[_gate_count]
		$HUD.target_gate_pos = _gates[_gate_count].global_position


func _finish_race():
	print("Race Finished")
	_is_racing = false
	$Jet.process_mode = Node.PROCESS_MODE_DISABLED
