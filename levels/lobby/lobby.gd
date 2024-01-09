extends Node


signal game_quit
signal level_selected(level: LevelData)


func move_camera_to_plane():
	$AnimationPlayer.play("main_menu_camera_transition")


func _on_title_screen_exited() -> void:
	$TitleScreen.hide()
	$MainMenu.show()
	$AnimationPlayer.play("main_menu_camera_transition")


func _on_main_menu_play_pressed() -> void:
	$MainMenu.hide()
	$PlayMenu.show()


func _on_main_menu_settings_pressed():
	pass # Replace with function body.


func _on_main_menu_quit_pressed():
	game_quit.emit()


func _on_play_menu_back_pressed():
	$PlayMenu.hide()
	$MainMenu.show()


func _on_play_menu_play_pressed(selected_level: LevelData):
	# TODO: refactor level loading and level data
	level_selected.emit(selected_level)
