extends Camera3D
## @tutorial: https://kidscancode.org/godot_recipes/3.x/3d/interpolated_camera/

@export var lerp_speed = 3.0
@export var target: Node3D
@export var offset = Vector3.ZERO

func _physics_process(delta):
	if !target:
		return

	var target_xform = target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)

	look_at(target.global_transform.origin, target.transform.basis.y)
