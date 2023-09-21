extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	_title_screen_transition_play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _title_screen_transition_play():
	$AnimationPlayer.play("title_screen_fade_in")
