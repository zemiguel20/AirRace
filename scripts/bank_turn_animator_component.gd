class_name BankTurnAnimatorComponent
extends Node


@export var targets: Array[Node3D]
@export var input_component: PlayerInputComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if !input_component:
		return
	
	var turn_input = input_component.turn_input
	var input_response = input_component.input_response
	var target_angle = deg_to_rad(45) * input_component.turn_input
	var weight = input_component.input_response * delta;
	for node in targets:
		node.rotation.z = lerpf(node.rotation.z, target_angle, input_response * delta)
