extends Area3D


func activate():
	set_deferred("monitoring", true)
	visible = true


func deactivate():
	set_deferred("monitoring", false)
	visible = false
