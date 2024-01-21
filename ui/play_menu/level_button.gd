extends Button


@export var level_scene: PackedScene


func _ready() -> void:
	var data = GameData.level_data.get(text)
	if data == null:
		%BestTime.text = "--:--.---"
	else:
		%BestTime.text = Utils.time_ms_to_string(data.back())
