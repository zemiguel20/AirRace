@icon("res://aircraft_controller/aeroplane_icon.svg")
## Simple arcade aircraft controller
class_name Aircraft
extends AnimatableBody3D

@export_range(1, 50, 1, "suffix:m/s")
var forward_velocity: float = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var thrust: Vector3 = forward_velocity * transform.basis.z
	move_and_collide(thrust*delta)
