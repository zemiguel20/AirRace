extends CanvasLayer


signal exited


func _ready():
	$AnimationPlayer.play("title_screen_fade_in")
	await $AnimationPlayer.animation_finished 
	# Wait for player input
	while not Input.is_anything_pressed():
		await get_tree().create_timer(0.1).timeout
	print("Title Screen exited")
	exited.emit()

