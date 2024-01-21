extends Node


func _on_lobby_game_quit() -> void:
	get_tree().quit()


func _on_lobby_level_selected(level: PackedScene) -> void:
	$LoadingScreen.show()
	$Lobby.queue_free()
	var level_instance = level.instantiate()
	add_child(level_instance)
	$LoadingScreen.hide()
