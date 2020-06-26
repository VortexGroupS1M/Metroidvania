#Class for handeling state behavier delegatet from `StateMachine` 
class_name State
extends Node

onready var state_machine := _get_state_machine(self)
onready var parent := get_parent()

func physics_process(_delta: float) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func enter(_args: Dictionary) -> void:
	pass


func exit() -> void:
	pass


func _get_state_machine(node: Node) -> Node:
	if node.is_in_group("state_machine"):
		return node
	return _get_state_machine(node.get_parent())
