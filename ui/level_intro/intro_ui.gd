extends CanvasLayer


@export var map_name := "Map Name"


signal countdown_started
signal countdown_ended


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MapName.text = map_name
	$AnimationTree.play("intro_sequence")


func _countdown_started():
	print("countdown started")
	countdown_started.emit()


func _countdown_ended():
	print("countdown ended")
	countdown_ended.emit()


func _set_timer_text(text:String):
	print(text)
	$Timer.text = text
