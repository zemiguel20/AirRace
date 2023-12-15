extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_screen_exited():
	$TitleScreen.hide()
	$MainMenu.show()


func _on_main_menu_play_pressed():
	$MainMenu.hide()
	$PlayMenu.show()


func _on_main_menu_settings_pressed():
	pass # Replace with function body.


func _on_main_menu_quit_pressed():
	get_tree().quit()


func _on_play_menu_back_pressed():
	$PlayMenu.hide()
	$MainMenu.show()


func _on_play_menu_play_pressed(selected_level: LevelData):
	$PlayMenu.hide()
	$LoadingScreen.show()
	$Lobby.queue_free()
	var level_instance = selected_level.level_scene.instantiate()
	add_child(level_instance)
	$LoadingScreen.hide()
