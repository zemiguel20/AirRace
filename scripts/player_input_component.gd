class_name PlayerInputComponent
extends Node


@export var input_response = 8.0
var pitch_input = 0.0
var turn_input = 0.0


func _process(delta):
	# Read input
	pitch_input = Input.get_axis("pitch_down", "pitch_up")
	if Settings.inverted_pitch_input:
		pitch_input = pitch_input * -1
	turn_input = Input.get_axis("turn_left", "turn_right")
	if Settings.inverted_turn_input:
		turn_input = turn_input * -1
