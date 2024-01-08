@tool # For visualization in editor
extends Button


@export var level_data: LevelData:
	set(new_level_data):
		level_data = new_level_data
		if new_level_data != null:
			# Update name, icon and time
			text = level_data.level_name
			icon = level_data.level_preview
			%BestTime.text = _best_time_to_string(level_data.best_time_centiseconds)
		else:
			text = "Test"
			icon = GradientTexture2D.new()
			%BestTime.text = _best_time_to_string(0)


func _best_time_to_string(best_time_centiseconds:int) -> String:
	var minutes:int = best_time_centiseconds / 6000
	var seconds:int = (best_time_centiseconds % 6000) / 100
	var centiseconds:int = (best_time_centiseconds % 6000) % 100
	var best_time_str = "%d:%02d.%02d" % [minutes, seconds, centiseconds]
	return best_time_str
