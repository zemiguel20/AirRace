extends CanvasLayer

signal title_screen_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreen.activate()
	$MainMenu.visible = false

func _on_title_screen_exited():
	$TitleScreen.visible = false
	$MainMenu.visible = true
	title_screen_exited.emit()
