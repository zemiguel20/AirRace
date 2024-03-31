extends Camera3D
## @tutorial: https://kidscancode.org/godot_recipes/3.x/3d/interpolated_camera/

@export var lerp_speed: float = 3.0
@export var target: Node3D
@export var offset: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if !target:
		return
	var target_pos = target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
	look_at(target.global_transform.origin, Vector3.UP)
