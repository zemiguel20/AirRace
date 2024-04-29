class_name MaterialChangerComponent
extends Node


@export var _target : MeshInstance3D

var _primary_mat: StandardMaterial3D
var _second_mat: StandardMaterial3D


func _ready(): 
	if !_target:
		push_error("No target or base material")
		return
	
	_primary_mat = _target.get_surface_override_material(0)
	_second_mat = _target.get_surface_override_material(1)


func _process(_delta):
	if !_target:
		return
	_primary_mat.albedo_color =  Settings.aircraft_primary_color
	_second_mat.albedo_color = Settings.aircraft_secondary_color
