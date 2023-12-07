extends Control


signal exited


func play():
	# Animation
	visible = true
	$AnimationPlayer.play("title_screen_fade_in")
	await $AnimationPlayer.animation_finished 
	# Wait for player input
	while not Input.is_anything_pressed():
		await get_tree().create_timer(0.1).timeout
	# Exit title screen
	visible = false
	exited.emit()

