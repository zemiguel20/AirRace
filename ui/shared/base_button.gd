extends Button


const GROW_SCALE = Vector2(1.1, 1.1)
const ANIM_DURATION = 0.1


func _grow():
	if not disabled:
		var tween: Tween = create_tween()
		tween.tween_property(self, "scale", GROW_SCALE, ANIM_DURATION)


func _shrink():
	if not disabled:
		var tween: Tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ONE, ANIM_DURATION)
