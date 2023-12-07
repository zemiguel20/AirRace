extends Node

func _on_ui_title_screen_exited():
	$AnimationPlayer.play("main_menu_camera_transition")
