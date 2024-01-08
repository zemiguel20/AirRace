extends CanvasLayer


signal back_pressed
signal play_pressed(selected_level:LevelData)

var _selected_level: LevelData

@export var button_group: ButtonGroup


func _ready() -> void:
	button_group.pressed.connect(_on_map_button_pressed)

	
func _exit_tree() -> void:
	button_group.pressed.disconnect(_on_map_button_pressed)


func _on_scroll_container_resized():
	# WORKAROUND to ScrollContainer content not expanding
	# Update VBoxContainer minimum size
	# NOTE: subtracting a bit to make room for scrollbar, otherwise signal infinite loop and crash
	var container_size = $Panel/ScrollContainer.size - Vector2(20,20)
	$Panel/ScrollContainer/VBoxContainer.custom_minimum_size = container_size


func _on_back_button_pressed():
	print("Back pressed")
	back_pressed.emit()


func _on_play_button_pressed():
	print("Play pressed")
	play_pressed.emit(_selected_level)


func _on_map_button_pressed(button: BaseButton) -> void:
	print(button.name + " selected")
	_selected_level = button.level_data
	$Panel/PlayButton.disabled = false

