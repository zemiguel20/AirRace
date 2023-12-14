extends CanvasLayer


signal back_pressed
signal play_pressed


func _on_scroll_container_resized():
	# WORKAROUND to ScrollContainer content not expanding
	# Update VBoxContainer minimum size
	# NOTE: subtracting a bit to make room for scrollbar, otherwise signal infinite loop and crash
	var container_size = $Panel/ScrollContainer.size - Vector2(20,20)
	$Panel/ScrollContainer/VBoxContainer.custom_minimum_size = container_size


func _on_back_button_pressed():
	back_pressed.emit()


func _on_play_button_pressed():
	play_pressed.emit()
