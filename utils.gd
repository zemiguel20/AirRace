class_name Utils


static func time_ms_to_string(time_ms: int) -> String:
	@warning_ignore("integer_division")
	var minutes:int = time_ms / 60000
	@warning_ignore("integer_division")
	var seconds:int = (time_ms % 60000) / 1000
	var miliseconds:int = (time_ms % 60000) % 1000
	var time_str = "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
	return time_str
