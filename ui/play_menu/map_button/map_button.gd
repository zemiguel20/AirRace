extends Button

@export var level_data: LevelData

signal selected(level: LevelData)


func _ready():
	if level_data != null:
		%MapName.text = level_data.level_name
		%MapPreview.texture = level_data.level_preview
		%BestTime.text = _best_time_to_string(level_data.best_time_centiseconds)


func _best_time_to_string(best_time_centiseconds:int) -> String:
	var minutes:int = best_time_centiseconds / 6000
	var seconds:int = (best_time_centiseconds % 6000) / 100
	var centiseconds:int = (best_time_centiseconds % 6000) % 100
	var best_time_str = "%d:%02d.%02d" % [minutes, seconds, centiseconds]
	return best_time_str


# To be set by the Menu which manages which button is selected
func set_selected(state:bool):
	if state == true:
		$SelectedBackground.show()
	else:
		$SelectedBackground.hide()


func _on_pressed():
	selected.emit(level_data)
