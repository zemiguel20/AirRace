extends CanvasLayer


signal back_pressed
signal play_pressed(selected_level: PackedScene)


@export var button_group: ButtonGroup


func _ready() -> void:
	button_group.pressed.connect(_on_map_selected)

	
func _exit_tree() -> void:
	button_group.pressed.disconnect(_on_map_selected)


func _on_scroll_container_resized():
	# HACK to ScrollContainer content not expanding
	# Update VBoxContainer minimum size
	# NOTE: subtracting a bit to make room for scrollbar, otherwise signal infinite loop and crash
	var container_size = $Panel/ScrollContainer.size - Vector2(20,20)
	$Panel/ScrollContainer/VBoxContainer.custom_minimum_size = container_size


func _on_back_button_pressed():
	print("Back pressed")
	back_pressed.emit()


func _on_play_button_pressed():
	print("Play pressed")
	var selected_level = button_group.get_pressed_button().level_scene
	play_pressed.emit(selected_level)


func _on_map_selected(button: BaseButton) -> void:
	print(button.name + " selected")
	$Panel/PlayButton.disabled = false
