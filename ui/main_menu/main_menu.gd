extends CanvasLayer

signal play_pressed
signal settings_pressed
signal quit_pressed


func _on_play_button_pressed():
	print("Play pressed")
	play_pressed.emit()


func _on_settings_button_pressed():
	print("Settings pressed")
	settings_pressed.emit()


func _on_quit_button_pressed():
	print("Quit pressed")
	quit_pressed.emit()
