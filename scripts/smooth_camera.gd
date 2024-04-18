class_name SmoothCamera
extends Camera3D
## @tutorial: https://kidscancode.org/godot_recipes/3.x/3d/interpolated_camera/


@export var target: Node3D
@export var offset = Vector3(0, 0.2, -5.0)
@export var lerp_speed = 3.0
@export var look_ahead_offset = 8.0


func _ready() -> void:
	if !target:
		push_warning("Camera has no follow target.")


func _physics_process(delta: float) -> void:
	if !target:
		return
	
	var target_xform = target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)
	
	_look_at_target()


func reset_position():
	if !target:
		return
	
	global_transform = target.global_transform.translated_local(offset)
	_look_at_target()


func _look_at_target():
	# looking to point ahead of target while turning will result in increased visibility of the turning side
	var look_ahead_point = target.global_position + (target.basis.z * look_ahead_offset)
	look_at(look_ahead_point, target.basis.y)
