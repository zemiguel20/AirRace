extends CanvasLayer

signal title_screen_exited


# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreen.play()


func _on_title_screen_exited():
	title_screen_exited.emit()


func _quit_pressed():
	get_tree().quit()
