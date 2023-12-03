extends Control

signal exited
	
func activate():
	visible = true
	# Fade title screen in
	$AnimationPlayer.play("title_screen_fade_in")
	await $AnimationPlayer.animation_finished 
	# Wait for key press
	while not Input.is_anything_pressed():
		await get_tree().create_timer(0.1).timeout
	exited.emit()
